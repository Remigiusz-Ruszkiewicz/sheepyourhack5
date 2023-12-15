/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

sealed class Constants {
  Constants._();

  static const String equalSignSeparator = '=============================================';
  static const String dashSignSeparator = '-------';
  static const String serviceSuffix = 'service';
}

enum LoggerCommands {
  init,
  dispose,
}
