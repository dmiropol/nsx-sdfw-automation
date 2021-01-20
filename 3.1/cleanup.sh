#!/bin/bash

echo "Cleaning up IDS/IPS..."
python3 sdfwapi.py idps-rules.json delete
python3 sdfwapi.py idps-profiles.json delete

echo "Cleaning up Groups..."
python3 sdfwapi.py groups-env_tiers.json delete

echo 'All done!'
