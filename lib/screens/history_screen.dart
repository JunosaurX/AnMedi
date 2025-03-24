import 'package:flutter/material.dart';
import 'package:my_drug_info_app/models/drug_model.dart';

class HistoryScreen extends StatelessWidget {
  final List<Drug> history;
  final Function onDeleteHistory;
  final Function onUpdateHistory; // Add this parameter

  const HistoryScreen(
      {Key? key,
      required this.history,
      required this.onDeleteHistory,
      required this.onUpdateHistory})
      : super(key: key);

  // Function to show the confirmation dialog
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to clear your search history?'),
        actions: [
          TextButton(
            onPressed: () {
              onDeleteHistory(); // Clear the history
              Navigator.pop(context);
            },
            child: Text('Delete'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search History'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _showDeleteConfirmationDialog(context),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(history[index].name),
            subtitle: Text(history[index].description),
            onTap: () {
              onUpdateHistory(history[index]); // Update history when clicked
              Navigator.pop(context); // Close the history screen
            },
          );
        },
      ),
    );
  }
}
