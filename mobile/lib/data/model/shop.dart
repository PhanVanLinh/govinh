class Shop {
  final String name;
  final String slug;
  final String? icon;

  Shop({
    required this.name,
    required this.slug,
    this.icon,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      name: json['name'] as String,
      slug: json['slug'] as String,
      icon: json['icon'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'slug': slug,
      'icon': icon,
    };
  }
}
