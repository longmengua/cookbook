import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'l10n/messages_all.dart';

/// @author Waltor
/// @at 02.14.2020
/// @refer https://www.youtube.com/watch?v=IhsHGJEOSYM&t=314s
///
/// Step 1. Creating the AppLocalizations class,
/// Step 2. run the command => flutter pub run intl_translation:extract_to_arb --output-dir=lib/config/i18n lib/config/appLocalization.dart
/// Step 3. get a intl_message.arb file after done it, then modify name of that file to default language, like intl_en.arb.
/// Step 4. duplicate the intl.en.ard file with other language name, like intl_zh.arb
/// Step 5. run the command => flutter pub run intl_translation:generate_from_arb --generated-file-prefix=lib/config/i18n/ --no-use-deferred-loading lib/config/appLocalization.dart lib/config/i18n/*.arb
/// Step 6. get message.*.dart files after done it, then correct the path of files that has a mistaken path.
class DemoLocalizations {
  DemoLocalizations(this.localeName);

  static Future<DemoLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      return DemoLocalizations(localeName);
    });
  }

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  final String localeName;

  String get title {
    return Intl.message(
      'Hello World',
      name: 'title',
      desc: 'Title for the Demo application',
      locale: localeName,
    );
  }
}


class DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) => DemoLocalizations.load(locale);

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}
