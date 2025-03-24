import 'package:http/http.dart' as http;
import 'dart:convert';

// Service class to fetch drug information
class DrugService {
  // Function to fetch drug information based on the drug name
  static Future<Map<String, dynamic>> fetchDrugInfo(
    String drugName,
    String apiKey,
  ) async {
    final response = await http.get(
      Uri.parse(
        'https://api.deepseek.com/drugs?name=$drugName',
      ), // Replace with your API endpoint
      headers: {
        'Authorization': 'Bearer $apiKey', // Use the hardcoded API key here
      },
    );

    if (response.statusCode == 200) {
      // Parse the JSON response
      return jsonDecode(response.body);
    } else {
      // If the server returns an error, throw an exception
      throw Exception('Failed to load drug info');
    }
  }
}
