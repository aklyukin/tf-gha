#!/bin/bash

source /usr/local/commands.sh

setup
terraform-init
set-plan-args

terraform-apply
