#!/bin/bash

function setup() {
    if [[ "$INPUT_PATH" == "" ]]; then
        error_log "input 'path' not set"
        exit 1
    fi

    if [[ ! -d "$INPUT_PATH" ]]; then
        error_log "Path does not exist: \"$INPUT_PATH\""
        exit 1
    fi
}

function set-plan-args() {
    if [[ -n "$INPUT_VAR_FILE" ]]; then
        for file in $(echo "$INPUT_VAR_FILE" | tr ',' '\n'); do
            if [[ ! -f "$file" ]]; then
                error_log "Path does not exist: \"$file\""
                exit 1
            fi
            PLAN_ARGS="$PLAN_ARGS -var-file=$(relative_to "$INPUT_PATH" "$file")"
        done
    fi
}

function terraform-init() {
    (cd "$INPUT_PATH" && TF_WORKSPACE=$INPUT_WORKSPACE terraform init -input=false)
}

function terraform-plan() {
  (cd "$INPUT_PATH" && TF_WORKSPACE=$INPUT_WORKSPACE terraform plan -input=false $PLAN_ARGS)
}

function terraform-fmt() {
  (cd "$INPUT_PATH" && TF_WORKSPACE=$INPUT_WORKSPACE terraform plan -input=false $PLAN_ARGS)
}