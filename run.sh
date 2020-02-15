#!/bin/bash

if [ "$#" -ne 2 ]
then
	echo "Pass two files as parameters"
	exit 1
fi

make
./cop1 $1 $2
