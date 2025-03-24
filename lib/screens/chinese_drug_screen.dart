import 'package:flutter/material.dart';
import 'package:my_drug_info_app/models/drug_model.dart';
import 'package:my_drug_info_app/services/db_helper.dart';
import 'package:my_drug_info_app/widgets/chatbox_widget.dart'; // Import ChatboxWidget
import 'chinese_drug_detail_screen.dart';
import 'history_screen.dart';
import 'package:my_drug_info_app/screens/flashcard_screen.dart';
import 'package:my_drug_info_app/screens/test_screen.dart';
import 'settings_screen.dart';
import 'drugscreen_en.dart'; // Import English Drug Screen

class ChineseDrugScreen extends StatefulWidget {
  final Function(String) onThemeChanged;
  final Function(String) onLanguageChanged;

  const ChineseDrugScreen({
    Key? key,
    required this.onThemeChanged,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  _ChineseDrugScreenState createState() => _ChineseDrugScreenState();
}

class _ChineseDrugScreenState extends State<ChineseDrugScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Drug> _filteredDrugInfo = [];
  List<Drug> _searchHistory = [];

  bool _isLoading = false;
  bool _showChatBox = false;
  String _errorMessage = '';

  String _selectedTheme = 'System';
  String _selectedLanguage = 'en';

  @override
  void initState() {
    super.initState();
  }

  void _searchDrugInfo() async {
    setState(() => _showChatBox = false);

    final drugName = _searchController.text.trim().toLowerCase();
    if (drugName.isEmpty) {
      setState(() => _filteredDrugInfo = []);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final drugs = await DBHelper.getChineseDrugByName(
          drugName); // Fetch from Chinese database
      setState(() {
        _filteredDrugInfo = drugs
            .where((drug) => drug.name.toLowerCase().startsWith(drugName))
            .toList();
        _errorMessage = _filteredDrugInfo.isEmpty
            ? 'No Chinese drugs found with that name'
            : '';
      });
    } catch (e) {
      setState(() => _errorMessage = 'Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _goToHistoryScreen() {
    setState(() => _showChatBox = false);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryScreen(
          history: _searchHistory,
          onDeleteHistory: _clearSearchHistory,
          onUpdateHistory: _updateHistory,
        ),
      ),
    );
  }

  void _goToSettingsScreen() {
    setState(() => _showChatBox = false);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsScreen(
          onThemeChanged: (theme) {
            if (theme != null) {
              setState(() => _selectedTheme = theme);
              widget.onThemeChanged(theme);
            }
          },
          onLanguageChanged: (language) {
            if (language != null) {
              setState(() => _selectedLanguage = language);
              widget.onLanguageChanged(language);
            }
          },
        ),
      ),
    );
  }

  void _updateHistory(Drug drug) {
    setState(() {
      _searchHistory.remove(drug);
      _searchHistory.insert(0, drug);
    });
  }

  void _clearSearchHistory() {
    setState(() => _searchHistory.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      appBar: AppBar(
        title: const Text('Chinese Medicine'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.history), onPressed: _goToHistoryScreen),
          IconButton(
              icon: const Icon(Icons.settings), onPressed: _goToSettingsScreen),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search Chinese Medicine',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: _searchDrugInfo,
                    ),
                  ),
                  onChanged: (_) => _searchDrugInfo(),
                  onTap: () => setState(() => _showChatBox = false),
                ),
                const SizedBox(height: 10),
                if (_isLoading) const CircularProgressIndicator(),
                if (_errorMessage.isNotEmpty)
                  Text(_errorMessage,
                      style: const TextStyle(color: Colors.red)),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredDrugInfo.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_filteredDrugInfo[index].name),
                        subtitle: Text(_filteredDrugInfo[index].description),
                        onTap: () {
                          _updateHistory(_filteredDrugInfo[index]);
                          setState(() => _showChatBox = false);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChineseDrugDetailScreen(
                                drug: _filteredDrugInfo[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // **Integrated ChatboxWidget**
          if (_showChatBox)
            ChatboxWidget(
              isVisible: _showChatBox, // Pass the required isVisible parameter
              onClose: () => setState(() => _showChatBox = false),
            ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () => setState(() => _showChatBox = !_showChatBox),
              child: const Icon(Icons.help_outline),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 40),
          _buildSectionTitle('Drugs'),
          _buildDrawerItem('Western', Icons.medication, () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DrugScreen(
                        // Back to English Drugs screen
                        onThemeChanged: widget.onThemeChanged,
                        onLanguageChanged: widget.onLanguageChanged,
                      )),
            );
          }),
          _buildDrawerItem('Chinese', Icons.medication_liquid, () {}),
          const Divider(),
          _buildSectionTitle('Treatments'),
          _buildDrawerItem('Western', Icons.healing, () {}),
          _buildDrawerItem('Chinese', Icons.grass, () {}),
          const Divider(),
          _buildSectionTitle('Diagnosis'),
          _buildDrawerItem('Diagnosis', Icons.local_hospital, () {}),
          const Divider(),
          _buildSectionTitle('Test'),
          _buildDrawerItem('Flashcards', Icons.style, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FlashcardScreen()),
            );
          }),
          _buildDrawerItem('Test', Icons.quiz, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TestScreen()),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDrawerItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
