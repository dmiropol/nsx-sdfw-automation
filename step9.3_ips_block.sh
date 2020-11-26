#!/bin/bash

python3 sdfwapi.py ips-rules.json create
python3 sdfwapi.py ips-signatures-DROP.json create

echo 'All done!'
