#!/bin/bash

export SCRAM_ARCH=el8_amd64_gcc12
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SITECONFIG_PATH="/opt/offline/SITECONF/local"
#[ -d CMSSW_14_0_3 ] || cmsrel CMSSW_14_0_3
#cd CMSSW_14_0_3/src
#cmsenv
#git cms-init --ssh
#git cms-addpkg HLTrigger/Configuration
#scram b
#cd -
