#!/bin/bash

python sdfwapi.py ids-profiles.json create
python sdfwapi.py ids-rules.json create
python sdfwapi.py groups-environment.json create

echo 'All done!'
