#!/bin/bash

python3 sdfwapi.py ips-rules.json create
python3 sdfwapi.py ips-signatures.json create {\"action\":\"DROP\"}

echo 'All done!'
