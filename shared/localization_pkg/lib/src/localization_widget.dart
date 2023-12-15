/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class LocalizationWidget extends EasyLocalization {
  LocalizationWidget({
    required super.child,
    super.assetLoader,
    super.errorWidget,
    super.useOnlyLangCode,
    super.saveLocale,
    super.useFallbackTranslations = true,
    super.path = 'packages/localization_pkg/assets/l10n',
    super.startLocale,
    super.fallbackLocale = const Locale('en', 'EN'),
    super.supportedLocales = _supportedLocales,
    super.key,
  });
}

String langFromLocale(Locale locale) => _languageMap[locale] ?? locale.toLanguageTag();

const _supportedLocales = [
  Locale('en', 'EN'),
  Locale('pl', 'PL'),
  Locale('de', 'DE'),
  // Locale('NL', 'NL'),
];

final _languageMap = {
  _supportedLocales[0]: 'English',
  _supportedLocales[1]: 'Polski',
  _supportedLocales[2]: 'Deutsch',
  // _supportedLocales[3]: 'Niederländisch',
};

extension TranslateExtension on String {
  String trUpperCase({
    List<String>? args,
    Map<String, String>? namedArgs,
    String? gender,
    BuildContext? context,
  }) =>
      this.tr(args: args, namedArgs: namedArgs, gender: gender, context: context).toUpperCase();
}
