import 'package:geolocator/geolocator.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/greeting/weather_model.dart';
import 'package:glorifi/src/structure/base_controller.dart';

class WeatherController extends BaseController {
  final _dataHelper = DataHelperImpl.instance;
  Rx<WeatherModel> _weatherModel = WeatherModel().obs;

  WeatherModel get weatherModel => _weatherModel.value;

  @override
  void onInit() async {
    getWeatherInfo();
    super.onInit();
  }

  String get weather => weatherModel.city == ""
      ? ""
      : weatherModel.city.toString().length > 18
          ? "${weatherModel.state}\n"
          : "${weatherModel.city}, ${weatherModel.state}\n";

  Future<void> getWeatherInfo() async {
    Position? _position;
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      _position = position;
    }).catchError(print);

    String latlong = _position != null
        ? "${_position!.latitude}, ${_position!.longitude}"
        : "";

    final response = await _dataHelper.apiHelper.getWeather(latlong);
    response.fold(print, (model) {
      return _weatherModel(model);
    });
  }
}
