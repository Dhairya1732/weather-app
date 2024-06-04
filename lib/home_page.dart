import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/weather_model.dart';
import 'package:weather_app/weather_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _weatherService = WeatherService("1cf52e073fd5cfde6d4584547a804ec3");
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return "assets/animations/sunny.json";

    switch (mainCondition.toLowerCase()) {
      case "clouds":
      case "mist":
      case "haze":
      case "fog":
      case "smoke":
      case "dust":
        return "assets/animations/cloud.json";
      case "rain":
      case "drizzle":
      case "shower rain":
        return "assets/animations/rain.json";
      case "thunderstorm":
        return "assets/animations/thunder.json";
      case "clear":
        return "assets/animations/sunny.json";
      default:
        return "assets/animations/sunny.json";
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "Loading city..."),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition ?? "")),
            Text("${_weather?.temperature.round()} Degree Celsius"),
            Text(_weather?.mainCondition ?? ""),
          ],
        ),
      ),
    );
  }
}
