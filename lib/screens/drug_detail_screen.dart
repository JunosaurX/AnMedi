import 'package:flutter/material.dart';
import 'package:my_drug_info_app/models/drug_model.dart';
import 'package:my_drug_info_app/services/db_helper.dart';

class DrugDetailScreen extends StatelessWidget {
  final Drug drug;

  const DrugDetailScreen({Key? key, required this.drug}) : super(key: key);

  void _addToFlashcards(BuildContext context) async {
    await DBHelper.addDrugToFlashcards(drug);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to Flashcards!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(drug.name, style: const TextStyle(color: Colors.blue)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              drug.name,
              style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            const SizedBox(height: 20),
            // Description of the drug
            Text(
              'Description: ${drug.description}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            // Dosage of the drug
            Text(
              'Dosage: ${drug.dosage}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            // Uses of the drug
            Text(
              'Uses: ${drug.uses}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            // Side Effects of the drug
            Text(
              'Side Effects: ${drug.sideEffects}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            // Add to flashcards button
            ElevatedButton(
              onPressed: () => _addToFlashcards(context),
              child: const Text('Add to Flashcards'),
            ),
          ],
        ),
      ),
    );
  }
}
