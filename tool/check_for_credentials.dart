import 'dart:io';

void main() {
  final file = File('example/lib/main.dart');
  if (!file.existsSync()) {
    Logger.debug('${file.path} does not exist');
    exit(-1);
  }
  final content = file.readAsStringSync();
  const emptyCredentials = '''const apiToken = '';
const preDefinedOwnerName = '';
const preDefinedAppName = '';''';
  if (!content.contains(emptyCredentials)) {
    Logger.debug('${file.path} still contains credentials');
    exit(-1);
  }
  Logger.debug('${file.path} does not contain credentials');
}

class Logger {
  Logger._();

  static void debug(Object value) => print(value); // ignore: avoid_print
}
