#!/bin/bash

cmd=$(basename $0)

setuser builduser \
	bash -c "source /var/build/oe-init-build-env && export BB_ENV_EXTRAWHITE=\"${BB_ENV_EXTRAWHITE} SSTATE_DIR SSTATE_MIRRORS\" && ${cmd} $*"
