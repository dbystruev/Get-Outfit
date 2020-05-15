#!/bin/bash
# Go to the working directory
cd "$(dirname $0)"

# Create variable for the work dir and files which needs to be changed
WORKDIR="$(pwd -P)"
FILE1="$WORKDIR/orders/Code.js"
FILE2="$WORKDIR/../lib/controllers/network_controller.dart"

# Check that the file exist
function check_file_exists {
    if [ ! -f "$1" ]; then
        echo "File $1 is not found"
        exit
    fi
}

# Check that the files exist
check_file_exists "$FILE1"
check_file_exists "$FILE2"

# Check that the file does not exist
function check_file_absent {
    if [ -f "$1" ]; then
        echo "File $1 exists. Remove it to continue"
        exit
    fi
}

# Check that the old/new files do not exist
check_file_absent "$FILE1.new"
check_file_absent "$FILE2.new"
check_file_absent "$FILE1.old"
check_file_absent "$FILE2.old"

# Replace getResponseToken() keys with random values
function replace_keys {
    cat "$1" \
    | sed s/0x11111111/$2/ \
    | sed s/0x22222222/$3/ \
    | sed s/0x33333333/$4/ \
    | sed s/0x44444444/$5/ \
    | sed s/0x55555555/$6/ \
    | sed s/0x66666666/$7/ \
    | sed s/0x77777777/$8/ \
    | sed s/0x88888888/$9/ \
    > "$1.new"
}

# Generate random values
RANDOM1=$RANDOM
RANDOM2=$RANDOM
RANDOM3=$RANDOM
RANDOM4=$RANDOM
RANDOM5=$RANDOM
RANDOM6=$RANDOM
RANDOM7=$RANDOM
RANDOM8=$RANDOM

# Replace getResponseToken() keys with random values
replace_keys "$FILE1" $RANDOM1 $RANDOM2 $RANDOM3 $RANDOM4 $RANDOM5 $RANDOM6 $RANDOM7 $RANDOM8
replace_keys "$FILE2" $RANDOM1 $RANDOM2 $RANDOM3 $RANDOM4 $RANDOM5 $RANDOM6 $RANDOM7 $RANDOM8

# Move current files to old and new to current
mv "$FILE1" "$FILE1.old"
mv "$FILE2" "$FILE2.old"
mv "$FILE1.new" "$FILE1"
mv "$FILE2.new" "$FILE2"
