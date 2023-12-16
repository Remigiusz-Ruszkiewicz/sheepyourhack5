sealed class RegexPatterns {
  RegexPatterns._();

  static const String siPrefixRegexPattern = r'([-+]?\d*\.?\d+)([eE][-+]?\d+)';
  static const String labelRegexPattern = r'(\.0*|(?<=\.)0*)$';
}
