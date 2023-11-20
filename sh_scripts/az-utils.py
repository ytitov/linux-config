#!/bin/python3
from enum import Enum
import asyncio
import argparse
import yaml

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
                pass
            case Team.glue:
                return "NinjaCat\Data (Glue)"

p = argparse.ArgumentParser()
p.add_argument('command', type=Command, choices=list(Command), \
        help="""
info: show some info
view-issues: view some issues
""")
p.add_argument("--team", type=Team, choices=list(Team), help="Which team")

args = p.parse_args()

# -------------
async def read_pipe(name, pipe, show = True):
    r = ""
    while True:
        #buf = await pipe.read(10)
        buf = await pipe.readline()
        if not buf:
            break
        s = buf.decode().strip()
        r += s
        if show is True:
            print(f'{name}: {s}')
    if show is True:
        print(f'{name}: END')
    return r

async def run_cmd_async(cmd: str, commands):
    proc = await asyncio.create_subprocess_exec(cmd, *commands, \
        stdin=asyncio.subprocess.PIPE, \
        stdout=asyncio.subprocess.PIPE, \
        stderr=asyncio.subprocess.PIPE) 
    [return_code, std_out, std_err] = await asyncio.gather(proc.wait(), read_pipe("az:0", proc.stdout), read_pipe("az:1", proc.stderr))
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
        data = yaml.load(self.std_out, Loader = yaml.Loader)
        #output = yaml.dump(data, Dumper=yaml.Dumper)
        #return output
        print(data)
        for elem in data:
            self.show_element(elem)

    def show_element(self, elem):
        output = yaml.dump(elem, Dumper=yaml.Dumper)
        print(f"""
---- element ----
              {output}""")

    def to_yaml_str(self):
        data = yaml.load(self.std_out, Loader = yaml.Loader)
        output = yaml.dump(data, Dumper=yaml.Dumper)
        return output

class Queries:
    def trailing_cmds():
        return ["--org", "https://dev.azure.com/healthcatalyst"]

    def search_active():
        return "SELECT [System.Id], [System.Title], [System.AssignedTo], [System.State], [System.AreaPath], [System.IterationPath], [System.Tags], [System.CommentCount] FROM workitems WHERE [System.State] IN ('Active') ORDER BY [System.IterationPath]"

    def search_active_in_team(team: Team):
        area_path = team.area_path()
        print(f" searcing in team {team}, path: {area_path}")
        return f"SELECT [System.Id], [System.Title], [System.AssignedTo], [System.State], [System.AreaPath], [System.IterationPath], [System.Tags], [System.CommentCount] FROM workitems WHERE [System.AreaPath] IN ('{area_path}') AND [System.State] IN ('Active') ORDER BY [System.IterationPath]"
    

async def main():
    match args.command:
        case Command.info:
            print("Info")
            r = await run_cmd_async("az", ["boards", "query", "--wiql", Queries.search_active()] + Queries.trailing_cmds())
            r.show_fields()

        case Command.create_issue:
            print(f"Create an issue for {args.team}");

        case Command.view_issues:
            r = await run_cmd_async("az", ["boards", "query", "--wiql", Queries.search_active_in_team(args.team)] + Queries.trailing_cmds())
            r.show_fields()
        
asyncio.run(main())
