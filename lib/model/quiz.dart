class NormalModel {
  final String description;
  final List<OptionModel> options;

  NormalModel({required this.description, required this.options});

  // Factory constructor to parse from JSON
  factory NormalModel.fromJson(Map<String, dynamic> json) {
    return NormalModel(
      description: json['description'],
      options: (json['options'] as List<dynamic>)
          .map((e) => OptionModel.fromJson(e))
          .toList(),
    );
  }

  // Method to convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'options': options.map((e) => e.toJson()).toList(),
    };
  }
}

class OptionModel {
  final String description;
  final bool isCorrect;

  OptionModel({required this.description, required this.isCorrect});

  // Factory constructor to parse from JSON
  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      description: json['description'],
      isCorrect: json['is_correct'],
    );
  }

  // Method to convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'is_correct': isCorrect,
    };
  }
}
