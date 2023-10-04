class Loyalty {
  final int points;
  final String redeemUrl;
  final String tier;

  String get webRedeemUrl => redeemUrl.trim().isNotEmpty
      ? redeemUrl.trim()
      : "https://breakawayexperiences.com/breakawaypoints";

  Loyalty({
    this.points = 0,
    this.redeemUrl = "",
    this.tier = "",
  });

  factory Loyalty.fromJson(Map<String, dynamic> json) {
    return Loyalty(
      points: json['points'],
      redeemUrl: json['redeemUrl'],
      tier: json['tier'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['points'] = points;
    data['redeemUrl'] = redeemUrl;
    data['tier'] = tier;
    return data;
  }
}
