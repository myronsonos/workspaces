#!/bin/bash

# ---------------------------------------------------------------------------------------------
#                          Detect the host system and the environment
# ---------------------------------------------------------------------------------------------
export HOST_SYSTEM=$(python -c 'import platform; print platform.system().lower()')

echo "HOST_SYSTEM=$HOST_SYSTEM"

# Establish the base repository reference directory
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "THIS_DIR=$THIS_DIR"

echo "DIR_REPOSITORY=$DIR_REPOSITORY"
echo "DIR_VIRTUAL_ENVIRONMENT=$DIR_VIRTUAL_ENVIRONMENT"
echo "DIR_WORKSPACE_CONFIGURATION=$DIR_WORKSPACE_CONFIGURATION"

echo "EXECUTION_ENVIRONMENT=$EXECUTION_ENVIRONMENT"
echo "PYTHONPATH=$PYTHONPATH"

# ---------------------------------------------------------------------------------------------
#                           Install the system dependencies
# ---------------------------------------------------------------------------------------------
pushd $DIR_REPOSITORY/setup

SYSTEM_REQUIREMENTS_FILE="$THIS_DIR/platforms/$HOST_SYSTEM/system_requirements.txt"
SYSTEM_DEP_INSTALL_SCRIPT="$THIS_DIR/platforms/$HOST_SYSTEM/system_dependencies_install.sh"

eval "$SYSTEM_DEP_INSTALL_SCRIPT $SYSTEM_REQUIREMENTS_FILE"

# ---------------------------------------------------------------------------------------------
#                           Install the pip dependencies
# ---------------------------------------------------------------------------------------------
# TODO: Change this over to using a virtual environment

# Install the pip dependencies if they don't already exist
cat pip_requirements.txt |
while read nxtdep; do
    # Remove any leading whitespace
    nxtdep="$(echo -e "${nxtdep}" | sed -e 's/^[[:space:]]*//')"

    # If the line is not a comment line, process it as a dependency
    if [[ &nxtdep != \#*  ]]; then
        pip install --user --upgrade $nxtdep
    fi
done


# ---------------------------------------------------------------------------------------------
#                           Generate the testbed configuration file
# ---------------------------------------------------------------------------------------------

read -p "Please input the HHID of the Sonos household you'd like to use with automation: " hhid
read -p "Please input name of network interface to scan for Sonos devices on: " iface

# generate testbed.json file
pushd $DIR_REPOSITORY/utilities/src/testbed/
python create_testbed_json.py --output $EXECUTION_ENVIRONMENT --hhid="${hhid}" --discover="${iface}"
popd

# generate keycache
pushd $DIR_REPOSITORY/utilities/src/cert_manager
python master_cert_manager.py
popd

echo
echo "All done!"
