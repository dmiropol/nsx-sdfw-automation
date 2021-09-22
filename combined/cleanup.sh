#!/bin/bash

echo "Cleaning up IDS/IPS..."
python3 sdfwapi.py idps-rules.json delete
python3 sdfwapi.py idps-profiles.json delete


echo "Cleaning up DFW..."
python3 sdfwapi.py dfw_policies2_app.json delete
python3 sdfwapi.py dfw_policies1_env.json delete
python3 sdfwapi.py dfw_default_policy-ALLOW.json create


echo "Cleaning up Groups..."
python3 sdfwapi.py groups-env_tiers.json delete
python3 sdfwapi.py groups-microseg.json delete
echo 'All done!'
