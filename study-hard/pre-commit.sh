#!/bin/bash
# save the file as

echo "Running Gradle clean test for errors"

# retrieving current working directory
CWD=`pwd`
MAIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# go to main project dir
cd $MAIN_DIR/../../

# running gradle clean test
./gradlew clean test
if [ $? -ne 0 ]; then
  echo
  echo "==> Error while testing the code"

  # go back to current working dir
  cd $CWD
  exit 1
fi

# go back to current working dir
cd $CWD