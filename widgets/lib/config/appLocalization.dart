import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'i18n/messages_all.dart';

/// @author Waltor
/// @at 02.14.2020
/// @refer https://www.youtube.com/watch?v=IhsHGJEOSYM&t=314s
///
/// Step 1. Creating the AppLocalizations class,
/// Step 2. run the command => flutter pub run intl_translation:extract_to_arb --output-dir=lib/config/i18n lib/config/appLocalization.dart
/// Step 3. get a intl_message.arb file after done it, then modify name of that file to default language, like intl_en.arb.
/// Step 4. duplicate the intl.en.ard file with other language name, like intl_zh.arb
/// Step 5. run the command => flutter pub run intl_translation:generate_from_arb --generated-file-prefix=lib/config/i18n/ --no-use-deferred-loading lib/config/appLocalization.dart lib/config/i18n/intl_en.arb lib/config/i18n/intl_zh.arb lib/config/i18n/intl_messages.arb
/// Step 6. get message.*.dart files after done it, then correct the path of files that has a mistaken path.
class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get title {
    return Intl.message(
      'Weather Application',
      name: 'title',
      desc: 'Title for the Weather Application',
    );
  }

  String get button {
    return Intl.message(
      'Get the Weather',
      name: 'button',
      desc: 'get weather button',
    );
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) {
    return false;
  }
}
