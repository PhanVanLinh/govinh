class Reward {
  final String icon;
  final String name;
  final int point;

  Reward({required this.icon, required this.name, required this.point});

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      icon: json['icon'] as String? ?? "",
      name: json['name'] as String? ?? "",
      point: json['point'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'icon': icon,
      'name': name,
      'point': point,
    };
  }
}
