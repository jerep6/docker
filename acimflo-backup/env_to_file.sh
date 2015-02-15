#!/bin/bash

# Write env variable to file

if [ -n "$1" ]; then
	env | grep "$1" > "/tmp/env_to_file.txt"
else
	env > "/tmp/env_to_file.txt"
fi

