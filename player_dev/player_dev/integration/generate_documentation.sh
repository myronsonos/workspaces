#!/bin/bash

# Establish the base repository reference directory
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DIR_WORKSPACE="$(cd $THIS_DIR/.. && pwd )"

DIR_REPOSITORY="/Users/myron.walker/Perforce/myron.walker_alpine/branches/player_dev"

echo "THIS_DIR=$THIS_DIR"
echo "DIR_REPOSITORY=$DIR_REPOSITORY"
echo "DIR_WORKSPACE=$DIR_WORKSPACE"

export PATH="/usr/local/opt/sphinx-doc/bin:$PATH"
echo "PATH=$PATH"

mkdir -p "$DIR_WORKSPACE/sphinx"
mkdir -p "$DIR_WORKSPACE/html"

# Set PYTHONPATH
export PYTHONPATH=$DIR_REPOSITORY/test/python/core/src:$DIR_REPOSITORY/test/python/tests/src:$DIR_REPOSITORY/test/python/utilities/src:$DIR_REPOSITORY/test/python/server/src:/opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages

# Document Pytest Automation
cd $DIR_REPOSITORY/test/python/tests/src

# Add an __init__.py file to each directory to help AutoDoc create links
#find -type d -exec touch {}/__init__.py \;

if [ ! -e $DIR_WORKSPACE/sphinx/conf.py ]; then
    /usr/local/bin/python2 -msphinx.apidoc -o $DIR_WORKSPACE/sphinx -F -H 'TestCase Documentation' .
fi

# Generate Pytest .RST files and move them to //core/src/sonos/doc where conf.py & static files live
/usr/local/bin/python2 -msphinx.apidoc -o $DIR_WORKSPACE/sphinx -H 'TestCase Automation' .

# Change directory to /doc/ and build html files from .rst files
cd $DIR_WORKSPACE/sphinx

# Build HTML files
/usr/local/bin/python2 -msphinx $DIR_WORKSPACE/sphinx $DIR_WORKSPACE/html
