#!/bin/bash

if [[ $1 =~ ^-?[0-9]+$ ]]
then
	echo "This is a number, and you need a text."
elif [[ -z $1 ]]
then
	echo "The parameter is not entered"
else
	echo $1
fi
