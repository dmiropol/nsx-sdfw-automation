#!/bin/bash

python sdfwapi.py groups-microseg.json create
python sdfwapi.py dfw_policies2_app.json create
python sdfwapi.py dfw_default_policy-DROP.json create

echo 'All done!'
