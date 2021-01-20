#!/bin/bash

python3 sdfwapi.py groups-microseg.json create
python3 sdfwapi.py dfw_policies2_app.json create
python3 sdfwapi.py dfw_default_policy-DROP.json create

echo 'All done!'
