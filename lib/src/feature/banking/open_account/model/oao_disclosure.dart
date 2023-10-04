class OAODisclosure {
  String title;
  String url;

  OAODisclosure({
    required this.title,
    required this.url,
  });

  factory OAODisclosure.fromJson(Map<String, dynamic> json) => OAODisclosure(title: json['desc'], url: json['docLink']);
}
