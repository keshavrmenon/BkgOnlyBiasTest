#!/bin/bash

massX=$1
massY=$2
icat=$3
maxpdf=$4
truth=0
while [ $truth -lt $maxpdf ]
do
    hadd higgsCombineDoubleHTag_${icat}_13TeV.NMSSM_X${massX}_Y${massY}_27_12_2020.t${truth}.mu_inj1.0.MultiDimFit.mH125.final.root higgsCombineDoubleHTag_${icat}_13TeV.NMSSM_X${massX}_Y${massY}_27_12_2020.t${truth}.mu_inj1.0.*MultiDimFit*
truth=$(($truth+1))
done
