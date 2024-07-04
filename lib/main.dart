import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view/location_search_screen.dart';

import 'package:weather_app/viewmodel/places_viewmodel.dart';
import 'package:weather_app/viewmodel/weather_viewmodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SearchLocationViewModel()),
          ChangeNotifierProvider(create: (_) => WeatherViewModel()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: const Color(0xFF212426)),
              useMaterial3: true,
            ),
            home: const SearchLocationScreen()));
  }
}
