import 'package:flutter/material.dart';

class InstructionManualScreen extends StatelessWidget {
  const InstructionManualScreen({Key? key}) : super(key: key); // Added const

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instruction Manual'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'App Version: 1.0.0',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Instructions:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '1. Search for drugs by typing the drug name in the search bar.\n'
              '2. Click on a drug to view detailed information.\n'
              '3. Use the chatbox to interact with the chatbot.\n'
              '4. Clear your search history using the History screen.\n'
              '5. Switch between Light and Dark mode in settings.\n'
              '6. Change language in settings (English, Simplified Chinese, Traditional Chinese).',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              'For more details, contact us via email or visit our website.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
