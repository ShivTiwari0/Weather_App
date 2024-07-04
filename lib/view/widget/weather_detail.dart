import 'package:flutter/material.dart';
import 'package:weather_app/utils/common.dart';

class WeatherDetail extends StatelessWidget {
  final String windSpeed;
  final String maxTemp;
  final String minTemperature;
  final String humidity;
  final String pressure;
  final String seaLevel;
  const WeatherDetail({
    super.key,
    required this.windSpeed,
    required this.maxTemp,
    required this.minTemperature,
    required this.humidity,
    required this.pressure,
    required this.seaLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(context, 0.25),
      width: width(context, 0.9),
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.wind_power,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 5),
                    weatherInfoCard(title: "Wind", value: "$windSpeed km/h"),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.sunny,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 5),
                    weatherInfoCard(title: "Max", value: maxTemp),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.wind_power,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 5),
                    weatherInfoCard(title: "Min", value: minTemperature),
                  ],
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.water_drop,
                      color: Colors.amber,
                    ),
                    const SizedBox(height: 5),
                    weatherInfoCard(title: "Humidity", value: "${humidity}%"),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.air,
                      color: Colors.amber,
                    ),
                    const SizedBox(height: 5),
                    weatherInfoCard(title: "Pressure", value: "${pressure}hPa"),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.leaderboard,
                      color: Colors.amber,
                    ),
                    const SizedBox(height: 5),
                    weatherInfoCard(title: "Sea-Level", value: "${seaLevel}m"),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Column weatherInfoCard({required String title, required String value}) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}

class WeatherData {}
