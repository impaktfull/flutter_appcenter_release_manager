import 'package:appcenter_release_manager/src/util/formatter/date_time_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Format Date', () {
    final result = DateTimeFormatter.format(DateTime(2020, 12, 11, 10, 30));
    expect(result, '2020-12-11 10:30');
  });
  test('Format Date with value below 10', () {
    final result = DateTimeFormatter.format(DateTime(2020, 1, 1, 1, 1));
    expect(result, '2020-01-01 01:01');
  });
}
