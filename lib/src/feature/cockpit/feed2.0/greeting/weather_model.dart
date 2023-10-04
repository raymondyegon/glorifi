class WeatherModel {
  WeatherModel({
    this.city = "",
    this.date = "",
    this.weather = "",
    this.temp = "",
    this.state = "",
  });

  String city;
  String date; // TODO: date is not needed can be removed
  String weather;
  String temp;
  String state;

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        city: json["city"] ?? "",
        date: json["date"] ?? "",
        weather: json["weather"] ?? "",
        temp: json["temp"] ?? "",
        state: json["state"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "date": date,
        "weather": weather,
        "temp": temp,
        "state": state,
      };
}
