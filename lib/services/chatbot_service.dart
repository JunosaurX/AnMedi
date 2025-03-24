import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatbotService {
  static const String _apiKey = 'sk-abadfe6faf104bcd9645c1c210139f85';
  static const String _apiUrl = 'https://api.deepseek.com/v1/chat/completions';

  static Future<String> fetchChatbotResponse(String message) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'deepseek-chat',
          'messages': [
            {'role': 'system', 'content': 'You are a helpful assistant.'},
            {'role': 'user', 'content': message},
          ],
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['choices'][0]['message']['content'] ??
            'No response';
      } else {
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
