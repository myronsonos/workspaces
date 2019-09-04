# ---------------------------------------------------------------------------------------------
#                          Detect the host system and the environment
# ---------------------------------------------------------------------------------------------
export HOST_SYSTEM=$(python -c 'import platform; print platform.system()')

echo "HOST_SYSTEM=$HOST_SYSTEM"

# TODO: Add some code here that outputs the system dependencies

# TODO: Add some code here that outputs the pip dependencies

# Establish the base repository reference directory
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPOSITORY_DIR="$( dirname $THIS_DIR )"

echo "THIS_DIR=$THIS_DIR"
echo "REPOSITORY_DIR=$REPOSITORY_DIR"
echo
echo "EXECUTION_ENVIRONMENT=$EXECUTION_ENVIRONMENT"
echo "WORKSPACE_CONFIGURATION=$WORKSPACE_CONFIGURATION"
echo "PYTHONPATH=$PYTHONPATH"

export
