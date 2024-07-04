import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/res/apptheme.dart';
import 'package:weather_app/utils/colors.dart';
import 'package:weather_app/utils/int_extensions.dart';
import 'package:weather_app/view/widget/weather_detail.dart';
import 'package:weather_app/view/widget/weather_icon.dart';
import 'package:weather_app/viewmodel/weather_viewmodel.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.name,
  });

  final double latitude;
  final double longitude;
  final String name;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherViewModel>(context, listen: false)
          .fetchWeather(widget.latitude, widget.longitude);
    });
  }

  Future<void> _refreshWeatherData() async {
    await Provider.of<WeatherViewModel>(context, listen: false)
        .fetchWeather(widget.latitude, widget.longitude);
  }

  @override
  Widget build(BuildContext context) {
    final weatherViewModel = Provider.of<WeatherViewModel>(context);
    String currentDate = DateFormat('EEEE d,MMMM yyyy').format(DateTime.now());
    String currentDateTime = DateFormat('hh:mm a').format(DateTime.now());
    String location = widget.name;
    List<String> parts = location.split(", ");
    String cityName = parts[0];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Weather Report',
          style: TextStyle(
            color: textPrimaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            color: textColorblack,
            onPressed: _refreshWeatherData,
          ),
        ],
        backgroundColor: appBarBackgroundColorGlobal,
      ),
      backgroundColor: appBarBackgroundColorGlobal,
      body: RefreshIndicator(
        onRefresh: _refreshWeatherData,
        child: weatherViewModel.loading
            ? const Center(child: CircularProgressIndicator())
            : weatherViewModel.weatherData != null
                ? SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              ' $cityName',
                              style: TextStyle(
                                color: textColorwhite,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          10.height,
                          Text(
                            currentDate,
                            style: TextStyle(
                              color: textColorwhite,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            currentDateTime,
                            style: TextStyle(
                              color: textColorwhite,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          15.height,
                          Text(
                            ' ${weatherViewModel.weatherData!.temperature.current.toStringAsFixed(2)} °C',
                            style: TextStyle(
                              color: textColorwhite,
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          10.height,
                          Text(
                            weatherViewModel.weatherData!.weather.first.main,
                            style: TextStyle(
                              color: textColorwhite,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            weatherViewModel
                                .weatherData!.weather.first.description,
                            style: TextStyle(
                              color: textColorwhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          WeatherIcon(
                            iconCode: weatherViewModel
                                .weatherData!.weather.first.icon,
                          ),
                          20.height,
                          WeatherDetail(
                            windSpeed: weatherViewModel.weatherData!.wind.speed
                                .toString(),
                            maxTemp:
                                ' ${weatherViewModel.weatherData!.maxTemperature.toStringAsFixed(2)} °C',
                            minTemperature:
                                ' ${weatherViewModel.weatherData!.minTemperature.toStringAsFixed(2)} °C',
                            humidity: weatherViewModel.weatherData!.humidity
                                .toString(),
                            pressure: weatherViewModel.weatherData!.pressure
                                .toString(),
                            seaLevel: weatherViewModel.weatherData!.seaLevel
                                .toString(),
                          ),
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      'Failed to load weather data',
                      style: TextStyle(color: textColorwhite),
                    ),
                  ),
      ),
    );
  }
}
