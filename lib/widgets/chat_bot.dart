import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatBotWidget extends StatefulWidget {
  final String apiKey;

  ChatBotWidget({required this.apiKey});

  @override
  _ChatBotWidgetState createState() => _ChatBotWidgetState();
}

class _ChatBotWidgetState extends State<ChatBotWidget> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  void _sendMessage() async {
    if (_messageController.text.isEmpty) return;

    setState(() {
      _messages.add({'user': _messageController.text});
      _isLoading = true;
    });

    final userMessage = _messageController.text;
    _messageController.clear();

    try {
      final response = await http.post(
        Uri.parse(
            'https://api.deepseek.com/chat'), // Make sure this is the correct API
        headers: {
          'Authorization': 'Bearer ${widget.apiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'message': userMessage}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          _messages.add({'bot': responseData['response']});
        });
      } else {
        setState(() {
          _messages.add({
            'bot': 'Error: Failed to get response (${response.statusCode})'
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({'bot': 'Error: $e'});
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 200,
          child: ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final message = _messages[index];
              return ListTile(
                title: message.containsKey('user')
                    ? Text('You: ${message['user']}')
                    : Text('Bot: ${message['bot']}'),
              );
            },
          ),
        ),
        TextField(
          controller: _messageController,
          decoration: InputDecoration(
            labelText: 'Type your question...',
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              onPressed: _sendMessage,
            ),
          ),
        ),
        if (_isLoading) CircularProgressIndicator(),
      ],
    );
  }
}
