#!/bin/bash

setuser builduser \
	bash -c "source oe-init-build-env && export BB_ENV_EXTRAWHITE=\"${BB_ENV_EXTRAWHITE} SSTATE_DIR SSTATE_MIRRORS\" && bitbake $*"
