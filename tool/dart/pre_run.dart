import 'dart:io';

/// This script is used to copy the content of the config.txt file to the config.dart file
/// We do this because the config.txt file is used to store the configuration of the app and
/// we don't want to expose the credentials to the outside world.
/// But we do want to publish a working example to pub.dev
void main() {
  final configDartFile = File('example/lib/config.dart');
  final configFile = File('example/lib/config.txt');
  final content = configFile.readAsStringSync();
  if (configDartFile.existsSync()) {
    configDartFile.deleteSync();
  }
  configDartFile.createSync(recursive: true);
  configDartFile.writeAsStringSync(content);
}
