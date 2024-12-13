import 'package:flutter/material.dart';
import 'package:mini_weather_app/components/weather_item.dart';
import 'package:intl/intl.dart';
import 'package:mini_weather_app/widgets/constants.dart';

class DetailPage extends StatefulWidget {
  final dynamic dailyWeatherForecast;

  const DetailPage({super.key, this.dailyWeatherForecast});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final Constants _constants = Constants();

  // Fungsi untuk mengambil data ramalan cuaca
  Map<String, dynamic> getForecastWeather(int index) {
    int maxWindSpeed =
        widget.dailyWeatherForecast[index]["day"]["maxwind_kph"].toInt();
    int avgHumidity =
        widget.dailyWeatherForecast[index]["day"]["avghumidity"].toInt();
    int chanceOfRain = widget.dailyWeatherForecast[index]["day"]
            ["daily_chance_of_rain"]
        .toInt();

    var parsedDate = DateTime.parse(widget.dailyWeatherForecast[index]["date"]);
    var forecastDate = DateFormat('EEEE, d MMMM').format(parsedDate);

    String weatherName =
        widget.dailyWeatherForecast[index]["day"]["condition"]["text"];
    String weatherIcon =
        weatherName.replaceAll(' ', '_').toLowerCase() + ".png";

    int minTemperature =
        widget.dailyWeatherForecast[index]["day"]["mintemp_c"].toInt();
    int maxTemperature =
        widget.dailyWeatherForecast[index]["day"]["maxtemp_c"].toInt();

    return {
      'maxWindSpeed': maxWindSpeed,
      'avgHumidity': avgHumidity,
      'chanceOfRain': chanceOfRain,
      'forecastDate': forecastDate,
      'weatherName': weatherName,
      'weatherIcon': weatherIcon,
      'minTemperature': minTemperature,
      'maxTemperature': maxTemperature
    };
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: _constants.primaryColor,
      appBar: AppBar(
        title: const Text('Forecast'),
        centerTitle: true,
        backgroundColor: _constants.primaryColor,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                print("Settings Tapped!");
              },
              icon: const Icon(Icons.settings),
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: size.height * 0.75,
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    right: 20,
                    left: 20,
                    child: Container(
                      height: 300,
                      width: size.width * 0.7,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.center,
                          colors: [
                            Color(0xffa9c1f5),
                            Color(0xff6696f5),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.1),
                            offset: const Offset(0, 25),
                            blurRadius: 3,
                            spreadRadius: -10,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            child: Image.asset(
                              "assets/${getForecastWeather(0)["weatherIcon"]}",
                              width: 150,
                            ),
                          ),
                          Positioned(
                            top: 150,
                            left: 30,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                getForecastWeather(0)["weatherName"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
