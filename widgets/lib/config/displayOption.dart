import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

class LanguageOptions extends StatefulWidget {
  @override
  _LanguageOptionsState createState() => _LanguageOptionsState();
}

class _LanguageOptionsState extends State<LanguageOptions> {
  Future future;

  @override
  void initState() {
    future = LocaleNamesLocalizationsDelegate().allNativeNames();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Map<String, String>>(
        future: future,
        builder: (context, snapshot) {
          return !snapshot.hasData ? null : optionListBuilder(snapshot.data);
        },
      ),
    );
  }

  Widget optionListBuilder(Map<String, String> data) {
    print(data);
    return null;
  }

  Widget option(String title, String subTitle, Locale locale) {
    return ListTile(
      leading: null,
      title: Text(title ?? ''),
      subtitle: Text(subTitle ?? ''),
    );
  }
}
