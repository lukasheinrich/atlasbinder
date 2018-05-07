#!/bin/sh
echo "setting up ATLAS and running: [$@]"
. /home/atlas/release_setup.sh
. /home/atlas/setup.sh
which jupyter
eval "$@"
