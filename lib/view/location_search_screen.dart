import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_app/res/apptheme.dart';
import 'package:weather_app/utils/colors.dart';
import 'package:weather_app/utils/const.dart';

import 'package:weather_app/view/weather_screen.dart';
import 'package:weather_app/view/widget/cusstom_pageroute.dart';
import 'package:weather_app/view/widget/location_list_tile.dart';
import 'package:weather_app/viewmodel/places_viewmodel.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  TextEditingController controller = TextEditingController();
  FocusNode cNode = FocusNode();
  String _locationCoordinates = '';
  double? lat;
  double? long;

  // getCurrentLocation() async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied ||
  //       permission == LocationPermission.deniedForever) {
  //     Utils.snackBar('Location Denied', context);
  //     LocationPermission ask = await Geolocator.requestPermission();
  //   } else {
  //     Position currentPosition = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.medium);
  //     setState(() {
  //       lat = currentPosition.latitude;
  //       long = currentPosition.longitude;
  //     });

  //     List<Placemark> placemarks = await placemarkFromCoordinates(lat!, long!);
  //     if (placemarks.isNotEmpty) {
  //       controller.text = placemarks[0].toString();
  //     }
  //   }
  // }

  Future<void> _getCoordinates(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      print(locations[0].latitude);
      if (locations.isNotEmpty) {
        setState(() {
          lat = locations[0].latitude;
          long = locations[0].longitude;
          _locationCoordinates = 'Latitude: $lat, Longitude: $long';
        });
      } else {
        setState(() {
          _locationCoordinates = 'No result found';
        });
      }
    } catch (e) {
      setState(() {
        _locationCoordinates = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    cNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SearchLocationViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: defaultPadding),
          child: CircleAvatar(
            backgroundColor: dividerColorGreyLight,
            child: SvgPicture.asset(
              location,
              height: 16,
              width: 16,
              color: primaryColor,
            ),
          ),
        ),
        title: Text(
          "Set Your Location",
          style: TextStyle(color: textColorblue),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: dividerColorGreyLight,
            child: IconButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              icon: const Icon(
                Icons.close,
              ),
            ),
          ),
          const SizedBox(width: defaultPadding)
        ],
      ),
      body: Column(
        children: [
          Form(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: TextFormField(
                onChanged: (value) {
                  viewModel.placeAutoComplete(value);
                },
                textInputAction: TextInputAction.search,
                controller: controller,
                focusNode: cNode,
                decoration: InputDecoration(
                  hintText: "Search your location",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: SvgPicture.asset(
                      locationpin,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            height: 4,
            thickness: 4,
            color: dividerColorGreyLight,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // getCurrentLocation();
                  },
                  icon: SvgPicture.asset(
                    location,
                    height: 16,
                  ),
                  label: const Text("Use my Current Location"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: dividerColorGreyLight,
                    foregroundColor: textColorLightTheme,
                    elevation: 0,
                    fixedSize: const Size(double.infinity, 40),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await _getCoordinates(controller.text);
                    if (lat != null && long != null) {
                      Navigator.of(context).push(CustomPageRoute(
                          child: WeatherScreen(
                            latitude: lat!,
                            longitude: long!,
                            name: controller.text,
                          ),
                          direction: AxisDirection.up));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(_locationCoordinates),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.done),
                  label: const Text("Done"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: dividerColorGreyLight,
                    foregroundColor: textColorLightTheme,
                    elevation: 0,
                    fixedSize: const Size(double.infinity, 40),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            height: 4,
            thickness: 4,
            color: dividerColorGreyLight,
          ),
          Expanded(
            child: viewModel.loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: viewModel.placePredictions.length,
                    itemBuilder: (context, index) => LocationListTile(
                      location: viewModel.placePredictions[index].description!,
                      press: () {
                        controller.text =
                            viewModel.placePredictions[index].description!;
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
