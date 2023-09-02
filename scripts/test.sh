#!/bin/bash

for test in $(ls out/test)
do
    echo "########################################"
    echo "# TEST: " $test
    echo "########################################"
    out/test/$test
done
