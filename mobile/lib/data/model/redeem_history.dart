class RedeemHistory {
  final String createdAt;
  final int point;

  RedeemHistory({required this.createdAt, required this.point});

  factory RedeemHistory.fromJson(Map<String, dynamic> json) {
    return RedeemHistory(
      createdAt: json['created_at'] as String,
      point: json['point'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'point': point,
    };
  }
}