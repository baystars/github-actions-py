MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := download

# all targets are phony
.PHONY: $(shell egrep -o ^[a-zA-Z_-]+: $(MAKEFILE_LIST) | sed 's/://')

GITHUB_ACCOUNT=foo
GITHUB_REPO=github-actions-test
GITHUB_TOKEN=xxxxx
GITHUB_ARTIFACT=my-artifact

# .env
ifneq ("$(wildcard ./.env)","")
  include ./.env
endif

hage: ## Get artifact download url
	curl -H "Authorization: token ${GITHUB_TOKEN}"  ${actions_artifacts_list}

get-url: ## Get artifact download url
	$(eval URL := $(shell curl -s -H "Authorization: token ${GITHUB_TOKEN}" https://api.github.com/repos/${GITHUB_ACCOUNT}/${GITHUB_REPO}/actions/artifacts?per_page=5 | jq ".artifacts | sort_by(.created_at) | reverse" | jq "map(select(.name == \"${GITHUB_ARTIFACT}\"))" | jq -r ".[0] | .url"))

download: get-url ## Show only project name
	@curl -s -L -H "Authorization: token ${GITHUB_TOKEN}" -o data/${GITHUB_ARTIFACT}.zip ${URL}/zip
	ls -l data/${GITHUB_ARTIFACT}.zip

help: ## Print this help
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
