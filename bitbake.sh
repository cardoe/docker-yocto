#!/bin/bash

setuser builduser \
	bash -c "source oe-init-build-env && bitbake $@"
