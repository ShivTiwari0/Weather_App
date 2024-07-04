import 'package:flutter/material.dart';
import 'package:weather_app/model/auto_complete_prediction.dart';
import 'package:weather_app/model/place_auto_copmlete_response.dart';
import 'package:weather_app/repositories/networkrepo.dart';
import 'package:weather_app/utils/const.dart';

class SearchLocationViewModel with ChangeNotifier {
  List<AutocompletePrediction> _placePredictions = [];
  bool _loading = false;

  List<AutocompletePrediction> get placePredictions => _placePredictions;
  bool get loading => _loading;

  void placeAutoComplete(String query) async {
    _loading = true;
    notifyListeners();

    Uri uri = Uri.https(
      "maps.googleapis.com",
      "maps/api/place/autocomplete/json",
      {
        "input": query,
        "key": apikey,
      },
    );
    final response = await NetworkUtilties.frtchurl(uri);
    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        _placePredictions = result.predictions!;
      }
    }

    _loading = false;
    notifyListeners();
  }
}
