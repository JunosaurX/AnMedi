import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/drugscreen_en.dart';
import 'package:my_drug_info_app/l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _selectedTheme = 'System'; // Default theme
  Locale _selectedLocale = const Locale('en'); // Default locale

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Western Drug Dictionary', // Updated title
      theme: _selectedTheme == 'Light'
          ? ThemeData.light()
          : _selectedTheme == 'Dark'
              ? ThemeData.dark()
              : ThemeData.fallback(),
      locale: _selectedLocale, // Update locale dynamically
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('zh', ''), // Simplified Chinese
        Locale('zh', 'TW'), // Traditional Chinese
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      home: DrugScreen(
        onThemeChanged: _onThemeChanged,
        onLanguageChanged: _onLanguageChanged,
      ),
    );
  }

  // Handle theme change
  void _onThemeChanged(String? theme) {
    setState(() {
      _selectedTheme = theme ?? 'System';
    });
  }

  // Handle language change properly
  void _onLanguageChanged(String? languageCode) {
    if (languageCode != null) {
      setState(() {
        _selectedLocale = Locale(languageCode);
      });
    }
  }
}
