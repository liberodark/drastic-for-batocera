#!/bin/bash

export LC_ALL=C

# Move to the game directory
cd "$(dirname "$(realpath "$0")")" || exit

# Run the game
LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:./usr/lib" ./drastic

exit 0