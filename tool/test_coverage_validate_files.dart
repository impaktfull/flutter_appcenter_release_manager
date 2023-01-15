import 'dart:io';

void main() {
  printMessage(
      'Start a check to make sure we have a test file for every sourcecode file');
  final sourceCodeFolder = Directory('lib');
  final testSourceCodeFolder = Directory('test');

  if (!sourceCodeFolder.existsSync()) {
    throw ArgumentError('lib dir not found');
  } else if (!testSourceCodeFolder.existsSync()) {
    throw ArgumentError('test dir not found');
  }
  final sourceCodeTodoFiles = <File>[];
  final sourceFiles = <File>[];
  sourceCodeFolder.listSync(recursive: true).forEach((element) {
    if (element is File) {
      if (element.path.endsWith('.dart')) {
        sourceFiles.add(element);
      }
    }
  });

  printMessage('');
  printMessage(
      'Detected ${sourceFiles.length} source files (with excluded folders/files: .g.dart, lib/vendor/**, lib/util/locale**)');

  final sourceCodeFiles = sourceFiles.where((file) {
    final path = file.path;
    if (path.endsWith('.g.dart')) {
      return false;
    } else if (path.startsWith('lib/vendor/')) {
      return false;
    } else if (path.startsWith('lib/util/locale')) {
      return false;
    }
    for (final excludedFile in excludedEndsWithFiles) {
      if (path.endsWith(excludedFile)) return false;
    }
    return true;
  });
  printMessage('');
  printMessage('Detected ${sourceCodeFiles.length} source files');

  sourceCodeFiles.forEach((file) {
    final cleanupFile =
        file.path.replaceFirst('lib/', '').replaceFirst('.dart', '');
    final testFile = File('test/${cleanupFile}_test.dart');
    if (!testFile.existsSync()) {
      sourceCodeTodoFiles.add(testFile);
    }
  });
  printMessage('');
  printMessage('Detected ${sourceCodeTodoFiles.length} untested files');

  printMessage('');
  printMessage(
      'Exclude ${excludedFiles.length} files (no tests needed for these)');
  sourceCodeTodoFiles.removeWhere((file) => excludedFiles.contains(
      file.path.replaceFirst('test/', '').replaceFirst('_test.dart', '.dart')));

  printMessage('');
  printMessage(
      'Detected ${sourceCodeTodoFiles.length} untested files after filter');

  printMessage('');
  printMessage('There are no test yet created for:');
  printMessage('');
  (sourceCodeTodoFiles
        ..sort((file1, file2) => file1.path.compareTo(file2.path)))
      .forEach((file) {
    printMessage('${file.path}');
  });
  printMessage('');
  if (sourceCodeTodoFiles.isNotEmpty) {
    printMessage(
        'You need to create ${sourceCodeTodoFiles.length} extra test files');
    exit(-1);
  }
}

List<File> getFiles(Directory directory) {
  final files = <File>[];
  final data = directory.listSync();
  for (final info in data) {
    final file = File(info.path);
    final dir = Directory(info.path);
    if (dir.existsSync()) {
      files.addAll(getFiles(dir));
    } else {
      files.add(file);
    }
  }
  return files;
}

const excludedFiles = <String>[];

const excludedEndsWithFiles = <String>[];

void printMessage(String message) {
  // ignore: avoid_print
  print(message);
}
