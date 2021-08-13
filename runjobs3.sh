#!/bin/bash
s0=1000
s1=123456
mass=$1
icat=$2
maxpdfindex=$3
massY=$4
pdfidx=0
set -x
while [ $pdfidx -lt $maxpdfindex ] 
do
for iter in {0..1}
do
        echo "source runBias_.sh NMSSM $mass $icat $pdfidx $(($s0+$iter)) $(($s1+$iter)) $massY"
	sh runBias_.sh NMSSM $mass $icat $pdfidx $(($s0+$iter)) $(($s1+$iter)) $massY
done
pdfidx=$(($pdfidx+1))
done
set +x
