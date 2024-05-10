#!/bin/python3
# data model reference
# https://learn.microsoft.com/en-us/azure/devops/boards/work-items/guidance/work-item-field?view=azure-devops
from enum import Enum
import asyncio
import argparse
import yaml
import subprocess as sp
from datetime import datetime, timezone

class Command(Enum):
    info = 'info'
    view_issues = 'view-issues'
    create_issue = 'create-issue'

    def __str__(self):
        return self.value

class Team(Enum):
    empi = 'empi'
    mesh = 'mesh'
    glue = 'glue'

    def __str__(self):
        return self.value

    def area_path(self):
        match self:
            case Team.empi:
                return "NinjaCat\Data (Glue)\Team Consumer"
            case Team.mesh:
                return "NinjaCat\Platform (Mesh)"
            case Team.glue:
                return "NinjaCat\Data (Glue)"

p = argparse.ArgumentParser()
p.add_argument('command', type=Command, choices=list(Command), \
        help="""
to log into azure: 'az login --use-device-code'
info: show some info
view-issues: view some issues
""")
p.add_argument("--team", type=Team, choices=list(Team), help="Which team", default="empi")
p.add_argument("--title", type=str, help="Title of the issue when creating")
p.add_argument("--task-type", type=str, default="User Story", help="The type of the work item")
p.add_argument("--project", type=str, default="62397e06-cdac-4061-bd54-92034cfb596c", help="Leave this alone unless making an issue somewhere very odd")
p.add_argument("--org", type=str, default="https://dev.azure.com/healthcatalyst", help="Organization")

# list all connections
# az devops service-endpoint list --org="https://dev.azure.com/healthcatalyst" --project="62397e06-cdac-4061-bd54-92034cfb596c"
# show the deisred connection
#  az devops service-endpoint show --id="f0484d81-e169-4382-9dab-87de19fba7e4" --org="https://dev.azure.com/healthcatalyst" --project="62397e06-cdac-4061-bd54-92034cfb596c"
args = p.parse_args()

# -------------
async def read_pipe(name, pipe, show = False):
    r = ""
    while True:
        #buf = await pipe.read(10)
        buf = await pipe.readline()
        if not buf:
            break
        s = buf.decode().strip()
        r += s
        if show is True:
            print(f'{name}{s}')
    return r

async def run_cmd_async(cmd: str, commands, show = False):
    proc = await asyncio.create_subprocess_exec(cmd, *commands, \
        stdin=asyncio.subprocess.PIPE, \
        stdout=asyncio.subprocess.PIPE, \
        stderr=asyncio.subprocess.PIPE) 
    [return_code, std_out, std_err] = await asyncio.gather(proc.wait(), read_pipe("", proc.stdout, show = show), read_pipe("# Err: ", proc.stderr, show = show))
    return Results(std_out, std_err, return_code)

# -------------

class Results(object):
    std_out = ""
    std_err = ""
    return_code = 0

    def __init__(self, stdout: str, std_err: str, return_code: int):
        self.std_out = stdout
        self.std_err = std_err
        self.return_code = return_code

    def show_fields(self):
        if self.return_code != 0:
            print("There was an error running the command: ")
            print(f"-------:\n{self.std_err}\n-------")
        data = yaml.load(self.std_out, Loader = yaml.Loader)
        #output = yaml.dump(data, Dumper=yaml.Dumper)
        #return output
        #print(data)
        num = 0
        if data is not None:
            for elem in data:
                num += 1
                self.show_element(elem)
            print(f"# Number of items returned: {num}")
        else:
            print(f"# No data returned: {data}")

    def show_element(self, elem):
        print(elem)
        fields = elem.get('fields')
        match fields:
            case {"System.AssignedTo": {"uniqueName": s}}:
                fields['System.AssignedTo'] = s
            case _:
                pass
        match fields:
            case {"System.CreatedBy": {"uniqueName": s}}:
                fields['System.CreatedBy'] = s
            case _:
                pass
        issue_title = fields.get('System.Title')
        output = yaml.dump(elem, Dumper=yaml.Dumper)
        print(f"""
# {issue_title}
{output}""")

    def to_yaml_str(self):
        data = yaml.load(self.std_out, Loader = yaml.Loader)
        output = yaml.dump(data, Dumper=yaml.Dumper)
        return output

class Queries:
    select = ""
    def trailing_cmds():
        return ["--org", "https://dev.azure.com/healthcatalyst"]

    def search_active():
        return "SELECT [System.Id], [System.Title], [System.AssignedTo], [System.State], [System.AreaPath], [System.IterationPath], [System.Tags], [System.CommentCount] FROM workitems WHERE [System.State] IN ('Active') ORDER BY [System.IterationPath]"

    def search_in_team(team: Team, is_active = False):
        area_path = team.area_path()
        is_active_query = "AND [System.State] NOT IN ('Closed', 'Resolved')"
        if is_active is True:
            is_active_query = "AND [System.State] IN ('Active')"
        print(f"team: {team}")
        print(f"area_path: {area_path}")
        return f"SELECT [System.WorkItemType], [System.TeamProject], [System.Id], [System.CreatedDate], [System.Title], [System.AssignedTo], [System.State], [System.AreaPath], [System.IterationPath], [System.Tags], [System.CreatedBy], [System.BoardColumn] FROM workitems WHERE [System.AreaPath] IN ('{area_path}') {is_active_query} ORDER BY [System.CreatedDate]"
    

async def main():
    match args.command:
        case Command.info:
            print("Info")
            r = await run_cmd_async("az", ["boards", "query", "--wiql", Queries.search_active()] + Queries.trailing_cmds())
            r.show_fields()

        case Command.create_issue:
            print(f"Create an issue for {args.team}");
            if args.title is None or args.team is None:
                print("You must supply a title and team to create issue")
                exit(1)
            # az boards work-item create --title ... --area ... --description ... 
            area_path = args.team.area_path()
            now = datetime.now(timezone.utc)
            s = now.isoformat()
            filename = f"ado-issue-{args.team}-{s}.md"

            print(f"Creating issue content: {filename}")
            sp.run(['nvim', filename])
            with open(filename, 'r') as f:
                content = f.read().strip()
                print(content)
                #f"--area='{area_path}'",
                az_boards_create_cmd = ["boards", "work-item", "create", f"--project=\"{args.project}\"", f"--type=\"{args.task_type}\"", f"--area=\"{area_path}\"", f"--iteration=\"NinjaCat\Data (Glue)\"", f"--title=\"{args.title}\"",  f"--description=\"{content}\"", "--debug"]
                print(f"Running command: {az_boards_create_cmd}")
                r = await run_cmd_async("az", az_boards_create_cmd + Queries.trailing_cmds())
                r.show_fields()
            sp.run(['rm', filename])


        case Command.view_issues:
            print(f"running args {args}")
            r = await run_cmd_async("az", ["boards", "query", "--wiql", Queries.search_in_team(args.team)] + Queries.trailing_cmds())
            r.show_fields()
        
asyncio.run(main())
