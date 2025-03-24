import 'package:flutter/material.dart';
import 'package:my_drug_info_app/models/drug_model.dart';
import 'package:my_drug_info_app/services/db_helper.dart';
import 'package:flip_card/flip_card.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({Key? key}) : super(key: key);

  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  List<Drug> _flashcards = [];

  @override
  void initState() {
    super.initState();
    _loadFlashcards();
  }

  /// ✅ Load flashcards from the database
  Future<void> _loadFlashcards() async {
    final cards = await DBHelper.getFlashcards();
    setState(() => _flashcards = cards);
  }

  /// ✅ Delete a flashcard from the database
  Future<void> _deleteFlashcard(Drug drug) async {
    await DBHelper.deleteFlashcard(drug.name);
    _loadFlashcards(); // Refresh after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flashcards')),
      body: _flashcards.isEmpty
          ? const Center(child: Text('No flashcards added yet!'))
          : PageView.builder(
              itemCount: _flashcards.length,
              itemBuilder: (context, index) {
                final drug = _flashcards[index];
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlipCard(
                        direction: FlipDirection.HORIZONTAL,
                        front: _buildFlashcardFront(drug),
                        back: _buildFlashcardBack(drug),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => _deleteFlashcard(drug),
                        child: const Text("Remove from Flashcards"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _buildFlashcardFront(Drug drug) {
    return _flashcardContainer(
      child: Center(
        child: Text(
          drug.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildFlashcardBack(Drug drug) {
    return _flashcardContainer(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${drug.description}'),
            const SizedBox(height: 8),
            Text('Side Effects: ${drug.sideEffects}'),
            const SizedBox(height: 8),
            Text('Dosage: ${drug.dosage}'),
            const SizedBox(height: 8),
            Text('Uses: ${drug.uses}'),
          ],
        ),
      ),
    );
  }

  Widget _flashcardContainer({required Widget child}) {
    return Container(
      width: 300,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: child,
    );
  }
}
