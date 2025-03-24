import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_drug_info_app/models/drug_model.dart';
import 'package:my_drug_info_app/services/json_helper.dart'; // Import JSONHelper

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int _numQuestions = 5;
  List<Map<String, dynamic>> _questions = [];
  List<Drug> _allDrugs = [];
  bool _isLoading = true;
  Map<int, String> _selectedAnswers = {};
  bool _showCorrectAnswers = false;
  bool _testStarted = false;

  @override
  void initState() {
    super.initState();
    _fetchDrugs();
  }

  Future<void> _fetchDrugs() async {
    try {
      _allDrugs = await JSONHelper.loadDrugsFromJSON(); // Load from JSON
      if (_allDrugs.isEmpty) {
        print("⚠️ No drugs were loaded from JSON!");
      } else {
        print("✅ Drugs loaded: ${_allDrugs.length}");
      }
    } catch (e) {
      print("❌ Error fetching drugs: $e");
    }
    setState(() => _isLoading = false);
  }

  void _generateQuestions() {
    if (_allDrugs.isEmpty) {
      print("No drugs available!");
      setState(() {
        _questions = []; // Ensure no stale data
      });
      return;
    }

    List<Map<String, dynamic>> questions = [];
    final random = Random();
    List<String> questionTypes = ['uses', 'side_effects'];

    for (int i = 0; i < _numQuestions; i++) {
      Drug selectedDrug = _allDrugs[random.nextInt(_allDrugs.length)];
      String questionType = questionTypes[random.nextInt(questionTypes.length)];
      String questionText = questionType == 'uses'
          ? "Which drug is used for: ${selectedDrug.uses}?"
          : "Which drug has this side effect: ${selectedDrug.sideEffects}?";

      List<String> options = [selectedDrug.name];

      // Get 3 wrong answers
      List<String> wrongOptions = _allDrugs
          .where((drug) => drug.name != selectedDrug.name)
          .map((drug) => drug.name)
          .toList();

      if (wrongOptions.length < 3) {
        print("Warning: Not enough wrong answers. Filling with duplicates.");
        while (wrongOptions.length < 3) {
          wrongOptions.add(selectedDrug.name);
        }
      }

      wrongOptions.shuffle();
      options.addAll(wrongOptions.take(3));
      options.shuffle();

      questions.add({
        'question': questionText,
        'correctAnswer': selectedDrug.name,
        'options': options,
      });
    }

    setState(() {
      _questions = questions;
      _selectedAnswers.clear();
      _showCorrectAnswers = false;
      _testStarted = true;
    });

    print("✅ Questions generated: ${_questions.length}");
  }

  void _startTest(int numQuestions) {
    if (_allDrugs.isEmpty) {
      print("❌ Cannot start test - No drugs loaded!");
      return;
    }
    setState(() {
      _numQuestions = numQuestions;
      _testStarted = false;
    });
    _generateQuestions();
  }

  void _selectAnswer(int index, String selectedAnswer) {
    if (_showCorrectAnswers) return;
    setState(() {
      _selectedAnswers[index] = selectedAnswer;
    });
  }

  void _showResults() {
    setState(() {
      _showCorrectAnswers = true;
    });

    int correctCount = _selectedAnswers.entries
        .where((entry) => entry.value == _questions[entry.key]['correctAnswer'])
        .length;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Test Completed!"),
        content: Text("You got $correctCount/${_questions.length} correct!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _testStarted = false;
                _questions.clear();
              });
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Drug Knowledge Test')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text("How many questions do you want?",
                          style: TextStyle(fontSize: 18)),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => _startTest(5),
                            child: Text("5 Questions"),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () => _startTest(10),
                            child: Text("10 Questions"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (_testStarted)
                  Expanded(
                    child: ListView.builder(
                      itemCount: _questions.length,
                      itemBuilder: (context, index) {
                        final question = _questions[index];
                        String correctAnswer = question['correctAnswer'];
                        String? selectedAnswer = _selectedAnswers[index];

                        return Card(
                          margin: EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Q${index + 1}: ${question['question']}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Column(
                                  children:
                                      (question['options'] as List<String>)
                                          .map((option) {
                                    return Card(
                                      color: _showCorrectAnswers
                                          ? (option == correctAnswer
                                              ? Colors.green
                                              : selectedAnswer == option
                                                  ? Colors.red
                                                  : null)
                                          : null,
                                      child: ListTile(
                                        title: Text(option,
                                            style: TextStyle(fontSize: 18)),
                                        onTap: _showCorrectAnswers
                                            ? null
                                            : () =>
                                                _selectAnswer(index, option),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                if (_testStarted)
                  ElevatedButton(
                    onPressed: _selectedAnswers.length == _questions.length
                        ? _showResults
                        : null,
                    child: const Text("Submit"),
                  ),
                SizedBox(height: 20),
              ],
            ),
    );
  }
}
