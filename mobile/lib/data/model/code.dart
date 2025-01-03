class Code {
  final String id;
  final String value;
  final bool used;

  Code({required this.id, required this.value, required this.used});

  // Factory method to create an instance from JSON
  factory Code.fromJson(Map<String, dynamic> json) {
    return Code(
      id: json['id'].toString(),
      value: json['code'] ?? "",
      used: json['is_used'] == 0 ? false : true,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'used': used,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}