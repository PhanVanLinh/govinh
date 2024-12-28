class User {
  final String name;
  final String phone;
  final int point;

  User({required this.name, required this.phone, required this.point});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      phone: json['phone'] as String,
      point: json['point'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'point': point,
    };
  }
}