import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/greeting/weather_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/services/rewards_service.dart';

class WeatherWidget extends GetView<WeatherController> {
  final Color color;

  const WeatherWidget({Key? key, required this.color}) : super(key: key);

  Future<Position?> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      } else {
        controller.getWeatherInfo();
        RewardsService.allowLocationPermission();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          determinePosition();
        },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 10,
              ),
              Obx(
                () => Text(
                  controller.weatherModel.temp,
                  style: TextStyle(
                      color: color, fontSize: 14, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 7,
                ),
              ),
              SizedBox(width: 5),
              Obx(() => Text(
                    controller.weather,
                    overflow: TextOverflow.ellipsis,
                    textScaleFactor: 1,
                    maxLines: 1,
                    style: captionBold14Primary(color: color),
                  ))
            ]));
  }
}
