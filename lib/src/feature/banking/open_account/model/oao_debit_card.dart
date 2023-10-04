class OAODebitCard {
  String cardProductToken;
  String cardArt;
  String cardTitle;
  String cardSubtitle;
  String cardDescription;

  OAODebitCard({
    required this.cardProductToken,
    required this.cardArt,
    required this.cardTitle,
    required this.cardSubtitle,
    required this.cardDescription,
  });

  factory OAODebitCard.fromJson(Map<String, dynamic> json) {
    return OAODebitCard(
      cardProductToken: json['cardProductToken'],
      cardArt: json['cardArt'],
      cardTitle: json['cardTitle'],
      cardSubtitle: json['cardSubtitle'],
      cardDescription: json['cardDescription'],
    );
  }
}
