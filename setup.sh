#!/bin/bash

export SCRAM_ARCH=el8_amd64_gcc12
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SITECONFIG_PATH="/opt/offline/SITECONF/local"

kinit $(logname)@CERN.CH
ssh -f -N -D18081 $(logname)@cmsusr.cms

# chmod 755 *sh *py && chmod 644 setup.sh customize*py

#[ -d CMSSW_14_0_3 ] || cmsrel CMSSW_14_0_3
#cd CMSSW_14_0_3/src
#cmsenv
#git cms-init --ssh
#git cms-addpkg HLTrigger/Configuration
#scram b
#cd -
