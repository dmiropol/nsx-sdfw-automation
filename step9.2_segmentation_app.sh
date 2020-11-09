#!/bin/bash

python sdfwapi.py groups-microseg.json create
python sdfwapi.py dfw_policies2_app.json create

echo 'All done!'
