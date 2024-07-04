import 'package:weather_app/app_excaptions.dart';
import 'package:weather_app/data/network/base_apiservice.dart';
import 'package:weather_app/data/network/networkapi_services.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherRepository {
  final BaseApiServices _apiService = NetworkApiService();

  Future<WeatherModel> fetchWeather(double lat, double lon) async {
    try {
      print('repo1');
      final response = await _apiService.getGetApiResponse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=9bbe0be276b0e5ceba5c82fe25302143',
      );
      print('repo2');
      return WeatherModel.fromJson(response);
    } on FetchDataException catch (e) {
      throw Exception('Error: ${e.message}');
    } on BadRequestException catch (e) {
      throw Exception('Error: $e');
    } on UnaurthorisedException catch (e) {
      throw Exception('Error: $e');
    } on TooManyTaps catch (e) {
      throw Exception('Error: $e');
    } catch (e) {
      throw Exception('An unexpected error occurred');
    }
  }
}
