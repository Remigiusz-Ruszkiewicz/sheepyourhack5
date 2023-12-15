/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

sealed class RegexPatterns {
  RegexPatterns._();

  static const String siPrefixRegexPattern = r'([-+]?\d*\.?\d+)([eE][-+]?\d+)';
  static const String labelRegexPattern = r'(\.0*|(?<=\.)0*)$';
}
