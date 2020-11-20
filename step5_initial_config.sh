#!/bin/bash

python3 sdfwapi.py ids-profiles.json create
python3 sdfwapi.py ids-rules.json create
python3 sdfwapi.py ids-config.json create
python3 sdfwapi.py groups-environment.json create

echo 'All done!'
