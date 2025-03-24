import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:my_drug_info_app/models/drug_model.dart';

class JSONHelper {
  static Future<List<Drug>> loadDrugsFromJSON() async {
    try {
      String jsonString = await rootBundle.loadString('assets/drug_info.json');
      List<dynamic> jsonData = json.decode(jsonString);
      return jsonData.map((drug) => Drug.fromJson(drug)).toList();
    } catch (e) {
      print("❌ Error loading JSON: $e");
      return [];
    }
  }
}
