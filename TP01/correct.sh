#! /bin/sh

dune runtest &> runtest.out.txt
echo =============================================
cat runtest.out.txt
echo =============================================
echo $(grep "^ • " runtest.out.txt | wc -l) "failures"
if grep "^ • " runtest.out.txt; then false; else true; fi
