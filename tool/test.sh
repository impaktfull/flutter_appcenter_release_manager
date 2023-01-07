#!/bin/bash

dart run ./tool/coverage/test_coverage_helper.dart || exit -1;
flutter test --coverage || exit -1;
dart run ./tool/coverage/filter_test_coverage.dart || exit -1;
dart run ./tool/coverage/test_check_coverage.dart || exit -1;
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html