import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final String iconCode;

  const WeatherIcon({super.key, required this.iconCode});

  @override
  Widget build(BuildContext context) {
    final iconUrl = 'https://openweathermap.org/img/wn/$iconCode@2x.png';

    return Image.network(
      iconUrl,
      width: 150,
      height: 150,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        // Handle error if image fails to load
        return Icon(Icons.error); // Placeholder for error case
      },
    );
  }
}
