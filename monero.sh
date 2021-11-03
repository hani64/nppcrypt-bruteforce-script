#!/bin/bash
PWDLIST=$2
FILE=$1
get_result(){
    result="`nppcrypt --silent -a decrypt $1 -p "$2" 2>&1`"

    if [[ $result == *"error: Integrity check failed."* ]]; then
        echo "FAILED   : ${2}"
    else
        echo "FOUND!!! : Password is ${2}"
        echo "Contents : ${result}"
        exit 1
    fi

}
while IFS='' read -r PWD || [ -n "${PWD}" ]; do
    get_result "$FILE" "$PWD"
done < $PWDLIST

