import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'instruction_manual.dart';

class SettingsScreen extends StatefulWidget {
  final Function(String) onThemeChanged;
  final Function(String) onLanguageChanged;

  const SettingsScreen({
    Key? key,
    required this.onThemeChanged,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedTheme = 'System';
  String _selectedLanguage = 'en';

  void _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'yangjunxihenmang@gmail.com',
      query: Uri.encodeFull(
          'subject=Support Request&body=Hello, I need help with...'),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open email app')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Theme',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: _selectedTheme,
                  items: ['System', 'Light', 'Dark']
                      .map((theme) =>
                          DropdownMenuItem(value: theme, child: Text(theme)))
                      .toList(),
                  onChanged: (theme) {
                    if (theme != null) {
                      setState(() => _selectedTheme = theme);
                      widget.onThemeChanged(theme);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Language',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: _selectedLanguage,
                  items: [
                    {'code': 'en', 'label': 'English'},
                    {'code': 'zh', 'label': '简体中文'},
                    {'code': 'zh_TW', 'label': '繁體中文'} // Corrected code
                  ]
                      .map((lang) => DropdownMenuItem(
                          value: lang['code'], child: Text(lang['label']!)))
                      .toList(),
                  onChanged: (language) {
                    if (language != null) {
                      setState(() => _selectedLanguage = language);
                      widget.onLanguageChanged(language);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.email), // Simple mail icon
              title: const Text('Contact Us'),
              onTap: _sendEmail, // Opens email app
            ),
            ListTile(
              leading: const Icon(Icons.rate_review),
              title: const Text('Write a Review'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Redirecting to app store for review...')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InstructionManualScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
