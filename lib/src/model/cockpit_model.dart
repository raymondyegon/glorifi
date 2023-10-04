// To parse this JSON data, do
//
//     final modelCoffee = modelCoffeeFromJson(jsonString);


/*CockpitModel modelCoffeeFromJson(String str) => CockpitModel.fromJson(json.decode(str));

String modelCoffeeToJson(CockpitModel data) => json.encode(data.toJson());*/

class CockpitModel {
  CockpitModel(
      {required this.id,
      required this.name,
      required this.profileStatus,
      required this.memberSince});

  String id;
  String name;
  String profileStatus;
  String memberSince;

  factory CockpitModel.fromJson(Map<String, dynamic> json) => CockpitModel(
        id: json["id"],
        name: json["name"],
        profileStatus: json["profile_status"],
        memberSince: json["memberSince"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profile_status": profileStatus,
        "memberSince": memberSince,
      };
}
