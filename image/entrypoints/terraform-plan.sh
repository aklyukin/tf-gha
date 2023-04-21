#!/bin/bash

source /usr/local/commands.sh

setup
run-terraform-init
set-plan-args

run-plan

(cd $INPUT_PATH && terraform workspace list)