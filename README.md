# NSXT Security Demo
This demo is focusing on service defined firewall and IDS features of NSX-T. This is an  addition to https://github.com/vmware-nsx/eval-docs-ids-ips/ demo

# Overview
`sdfwapi.py` is a python script that utilizes NSXT policy API and pre-configured json files to provision distributed firewall policy rules, IDS polices and rules along with necessary security groups and services.

# Requirements
Unix-based machine running python 3.8+ with pip3

# Installation
Run `install.sh`

# Configuration
Edit `env_profile.json` file to match your setup
Edit other `*.json` files to match your setup

# Running demo
You can run the script by calling python script `sdfwapi.py` directly or by using prebuilt bash script files.
The python script expects to get 2 arguments: `.json` file and operation `create` or `delete`.

Running the 3.0 scripts: 
1. `step5<>`  - this creates SGs and IDS profiles and rules
2. `step9.1<>` - this creates Environment isolation DFW policy (Environment category)
3. `step9.2<>` - this creates microsegmentation DFW policy (Application category). Default L3 policy rule is set to "Drop".

Running the 3.1 scripts: 
1. `step5<>.sh`  - this creates SGs and IDS profiles and rules
2. `step8_ips.sh` - this changes configuration of rules and signatures to enforce the action


# Cleanup
Run  `cleanup.sh` - this restores environment to its initial state by deleting all created DFW rules, groups and IDS profiles.
Default L3 policy rule is set to "Allow".
