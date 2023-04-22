#!/bin/bash

source /usr/local/commands.sh

setup
terraform-init
set-plan-args

echo $HOME
terraform-plan
