import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:weather_app/app_excaptions.dart';
import 'package:weather_app/data/network/base_apiservice.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url, {Map<String, String>? headers}) async {
    dynamic responseJson;
    try {
      var response = await http
          .get(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      throw e;
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data,
      {Map<String, String>? headers}) async {
    dynamic responsejson;
    try {
      Response response = await post(
        Uri.parse(url),
        body: data,
        headers: headers,
      ).timeout(const Duration(seconds: 10));
      responsejson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responsejson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 429:
        throw TooManyTaps(response.body.toString());
      case 404:
        throw UnaurthorisedException(response.body.toString());
      case 403:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        throw FetchDataException(
            "Error with status code ${response.statusCode.toString()}");
    }
  }
}
