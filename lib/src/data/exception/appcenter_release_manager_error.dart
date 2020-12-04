class AppCenterReleaseManagerError extends Error {
  final String message;

  AppCenterReleaseManagerError({this.message});

  @override
  String toString() {
    if (message != null && message.isNotEmpty) {
      return 'AppCenter Release Manager Error with message:\n\n'
          '------------------------\n\n'
          '$message\n\n'
          '------------------------\n\n'
          '${super.toString()}';
    }
    return super.toString();
  }
}
