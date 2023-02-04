#!/bin/sh

# fail if any command fails

echo "🧩 Stage: Post-clone is activated .... "

# Set the -e flag to stop running the script in case a command returns
# a nonzero exit code.
set -e
 # debug log
 # set -x

brew install swiftlint
echo "swiftlint installed"

# This will create a copy of the template xcconfig file required
# to build the app.

FILE="$CI_WORKSPACE/Atlas/Configuration/secrets.xcconfig"
echo $FILE
if [ -f $FILE ]; then
    echo "$FILE already exists. Skipping."
else
    echo "Creating $FILE..."
    cp $CI_WORKSPACE/Meet/Configuration/secrets.template.xcconfig $FILE
    # Replace the line "API_KEY =" with "API_KEY = $API_KEY""
    sed -i -e "s/API_KEY =/API_KEY = $API_KEY/g" "$FILE"
    echo "update API Key"
fi

# echo $(<$FILE)
echo "🎯 Stage: Post-clone is done .... "
exit 0

# Something went wrong.
echo "Failed to replace API Key"
exit 1
