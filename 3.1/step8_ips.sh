#!/bin/bash

python3 sdfwapi.py idps-profiles-overwrite.json create
python3 sdfwapi.py idps-rules.json create  {\"action\":\"DETECT_PREVENT\"}

echo 'All done!'
