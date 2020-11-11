#!/bin/bash

python sdfwapi.py dfw_policies2_app.json delete
python sdfwapi.py dfw_policies1_env.json delete
python sdfwapi.py groups-microseg.json delete
python sdfwapi.py groups-environment.json delete
python sdfwapi.py ids-rules.json delete
python sdfwapi.py ids-profiles.json delete
python sdfwapi.py dfw_default_policy-ALLOW.json create

echo 'All done!'
