class HandleCommandException implements Exception {
  const HandleCommandException(this.message);

  final String message;

  @override
  String toString() => 'HandleCommandException: $message';
}
