
# Make sure xcode commandline tools are installed, these are required by brew
XCODE_INSTALLED=$(xcode-select -p 1>/dev/null;echo $?)
if [[ XCODE_INSTALLED != 0 ]]; then
    xcode-select --install
fi

# Make sure brew is installed


# Make sure brew is up-to-date


# Walk through the dependencies file and see if it is installed
cat "$0" |
while read nxtdep; do
    # Remove any leading whitespace
    nxtdep="$(echo -e "${nxtdep}" | sed -e 's/^[[:space:]]*//')"

    # If the line is not a comment line, process it as a dependency
    if [[ &nxtdep != \#*  ]]; then
        brew install $nxtdep
    fi
done
