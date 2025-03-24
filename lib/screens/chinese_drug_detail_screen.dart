import 'package:flutter/material.dart';
import 'package:my_drug_info_app/models/drug_model.dart';
import 'package:my_drug_info_app/services/db_helper.dart';

class ChineseDrugDetailScreen extends StatelessWidget {
  final Drug drug;

  const ChineseDrugDetailScreen({Key? key, required this.drug})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(drug.name), // Drug name
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the Chinese drug name (for example, 人参)
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
              onPressed: () async {
                await DBHelper.addDrugToFlashcards(
                    drug); // Add the drug to flashcards
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Drug added to Flashcards')),
                );
              },
              child: const Text('Add to Flashcards'),
            ),
          ],
        ),
      ),
    );
  }
}
