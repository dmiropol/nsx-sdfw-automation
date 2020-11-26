#!/bin/bash

echo "Cleaning up DFW..."
python3 sdfwapi.py dfw_policies2_app.json delete
python3 sdfwapi.py dfw_policies1_env.json delete
python3 sdfwapi.py groups-microseg.json delete
python3 sdfwapi.py groups-environment.json delete
python3 sdfwapi.py dfw_default_policy-ALLOW.json create

echo "Cleaning up IDS/IPS..."
python3 sdfwapi.py ids-rules.json delete
python3 sdfwapi.py ids-profiles.json delete
python3 sdfwapi.py ips-signatures-ALERT.json create

echo 'All done!'
