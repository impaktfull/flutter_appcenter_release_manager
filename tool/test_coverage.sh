#!/bin/bash

CURRENT=`pwd`
DIR_NAME=`basename "$CURRENT"`
if [ $DIR_NAME == 'tool' ]
then
  cd ..
fi

dart run tool/test_coverage_validate_files.dart || exit -1

dart run tool/test_coverage_create_helper.dart

fvm flutter test --coverage || exit -1

dart run tool/test_coverage_filter.dart

if [ "$1" == "ci" ]
then
  dart run tool/test_coverage_validate_percentage.dart
else
  genhtml coverage/lcov.info -o coverage/html
  open coverage/html/index.html
fi