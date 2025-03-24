class Drug {
  final String name;
  final String description;
  final String sideEffects;
  final String dosage;
  final String uses;

  Drug({
    required this.name,
    required this.description,
    required this.sideEffects,
    required this.dosage,
    required this.uses,
  });

  // Convert a Map into a Drug object (used when fetching from a database or JSON)
  factory Drug.fromJson(Map<String, dynamic> json) {
    return Drug(
      name: json['name'],
      description: json['description'],
      sideEffects: json['side_effects'],
      dosage: json['dosage'],
      uses: json['uses'],
    );
  }

  // Convert a Drug object into a Map (used for inserting into a database or converting to JSON)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'side_effects': sideEffects,
      'dosage': dosage,
      'uses': uses,
    };
  }
}
