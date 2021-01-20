#!/bin/bash

python3 sdfwapi.py groups-env_tiers.json create
python3 sdfwapi.py idps-config.json create
python3 sdfwapi.py idps-profiles.json create
python3 sdfwapi.py idps-rules.json create

echo 'All done!'
