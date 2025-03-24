import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  String get title => Intl.message('Drug Info App', name: 'title');
  String get search => Intl.message('Search Drug', name: 'search');
  String get settings => Intl.message('Settings', name: 'settings');
  String get language => Intl.message('Language', name: 'language');
  String get theme => Intl.message('Theme', name: 'theme');
  String get light => Intl.message('Light', name: 'light');
  String get dark => Intl.message('Dark', name: 'dark');
  String get system => Intl.message('System', name: 'system');
  String get about => Intl.message('About', name: 'about');
  String get review => Intl.message('Write a Review', name: 'review');
  String get help => Intl.message('Help', name: 'help');
  String get contact => Intl.message('Contact Us', name: 'contact');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh', 'zh_TW'].contains(locale.languageCode) ||
        (locale.languageCode == 'zh' && locale.countryCode == 'TW');
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
