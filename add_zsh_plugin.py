#!/usr/bin/env python
import re
import sys
from os.path import expanduser

zshrc = expanduser("~") + "/.zshrc" #~/.zshrc
custom_plugins = " ".join(sys.argv[1:])

zshrc_config = ""
with open(zshrc, 'a+') as f:
    zshrc_config = f.read()

match = re.search("^plugins=\((.*)\)", zshrc_config, re.M)

if match:
    plugins = match.group(1)
    plugins += " " + custom_plugins
    zshrc_config = re.sub("^plugins=(.*)", "plugins=(%s)" % plugins, zshrc_config, flags=re.M)
    print("plugins=(%s)" % plugins)
    with open(zshrc, 'w') as f:
        f.write(zshrc_config)
else:
    with open(zshrc, 'a+') as f:
        f.write("plugins=(%s)" % custom_plugins)


