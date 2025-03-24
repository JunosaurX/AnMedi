import 'package:flutter/material.dart';
import 'chat_bot.dart'; // Import ChatBotWidget

class ChatBotPopup extends StatelessWidget {
  final String apiKey; // Accept API key

  const ChatBotPopup({Key? key, required this.apiKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Ask your question'),
            SizedBox(height: 10),
            ChatBotWidget(apiKey: apiKey), // Pass API key to the ChatBotWidget
          ],
        ),
      ),
    );
  }
}
