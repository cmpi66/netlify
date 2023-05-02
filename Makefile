SHELL := /bin/bash
.POSIX:
.PHONY: help install upgrade-hugo serve build start initial updatetheme links

help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

updatetheme: # update theme
	hugo mod get github.com/razonyang/hugo-theme-bootstrap@master && \
	hugo mod tidy && \
	hugo mod npm pack && \
	npm update

links: # show broken links
	python hydra.py https://notes.munozpi.com --config hydra-config.json > report.yaml

# install: ## Install or update dependencies
# 	npm i
	# npm install -g markdownlint-cli
	# pre-commit install --install-hooks

HUGO_VERSION:=$(shell curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest | grep 'tag_name' | cut -d '"' -f 4 | cut -c 2-)

upgrade-hugo: ## Get the latest Hugo
	mkdir tmp/ && \
	cd tmp/ && \
	curl -sSL https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/hugo_extended_$(HUGO_VERSION)_Linux-64bit.tar.gz | tar -xvzf- && \
	doas mv hugo /usr/local/bin/ && \
	cd .. && \
	rm -rf tmp/
	hugo version

dev: ## Run the local development server
	hugo serve --noHTTPCache --disableFastRender --environment development

future: ## Run the local development server in the future
	hugo serve --buildFuture --disableFastRender --environment development

KILLPUB:=$(shell [ -d ./public ] && rm -rf ./public)

build: # build site and send algolia index
	 $(KILLPUB) hugo --gc --minify && hugo-theme-bootstrap-algolia

start: upgrade-hugo serve ## Update Hugo and start development server

initial: install upgrade-hugo serve ## Install tools and start development server
