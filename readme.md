# ~/.config folder
- this is so my config is syncronized accross all of my computers
- try to keep it linux neutral

### `bash_custom.sh`
- will need to add to `.bashrc`:
```
if [ -f ~/.config/bash_custom.sh ]; then
  . ~/.config/bash_custom.sh
fi
```

