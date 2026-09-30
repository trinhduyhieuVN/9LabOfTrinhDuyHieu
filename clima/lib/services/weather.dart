import '../services/networking.dart';
import 'location.dart';

class WeatherModel {
  WeatherModel({NetworkHelper? network})
      : _network = network ?? NetworkHelper();

  final NetworkHelper _network;

  Future<dynamic> getCityWeather(String cityName) async {
    final query = cityName.trim();
    if (query.isEmpty) {
      throw const WeatherException('Hãy nhập tên thành phố.');
    }

    final geocoding = await _network.getData(
      Uri.https('geocoding-api.open-meteo.com', '/v1/search', {
        'name': query,
        'count': '1',
        'language': 'vi',
        'format': 'json',
      }),
    );
    final results = geocoding['results'] as List<dynamic>?;
    if (results == null || results.isEmpty) {
      throw const WeatherException(
        'Không tìm thấy thành phố. Hãy thử nhập tên bằng tiếng Anh.',
      );
    }

    final place = results.first as Map<String, dynamic>;
    final name = place['name'] as String? ?? query;
    final country = place['country'] as String?;
    final admin1 = place['admin1'] as String?;
    final locality = [
      name,
      if (admin1 != null && admin1 != name) admin1,
      if (country != null) country,
    ].join(', ');

    return _getWeather(
      latitude: (place['latitude'] as num).toDouble(),
      longitude: (place['longitude'] as num).toDouble(),
      name: locality,
    );
  }

  Future<dynamic> getLocationWeather() async {
    final location = Location();
    await location.getCurrentLocation();
    return _getWeather(
      latitude: location.latitude!,
      longitude: location.longitude!,
      name: 'Vị trí hiện tại',
    );
  }

  Future<Map<String, dynamic>> _getWeather({
    required double latitude,
    required double longitude,
    required String name,
  }) async {
    final result = await _network.getData(
      Uri.https('api.open-meteo.com', '/v1/forecast', {
        'latitude': '$latitude',
        'longitude': '$longitude',
        'current': 'temperature_2m,weather_code',
        'timezone': 'auto',
      }),
    );
    final current = result['current'] as Map<String, dynamic>?;
    final temperature = current?['temperature_2m'] as num?;
    final code = current?['weather_code'] as num?;
    if (temperature == null || code == null) {
      throw const WeatherException(
          'Chưa có dữ liệu thời tiết cho địa điểm này.');
    }

    return {
      'name': name,
      'main': {'temp': temperature},
      'weather': [
        {'id': code.toInt()},
      ],
    };
  }

  String getWeatherIcon(int code) {
    if (code == 0) return '☀️';
    if (code <= 3) return '⛅';
    if (code == 45 || code == 48) return '🌫️';
    if (code >= 51 && code <= 57) return '🌦️';
    if (code >= 61 && code <= 67) return '🌧️';
    if (code >= 71 && code <= 77) return '🌨️';
    if (code >= 80 && code <= 82) return '🌧️';
    if (code == 85 || code == 86) return '🌨️';
    if (code >= 95) return '⛈️';
    return '🌤️';
  }

  String getMessage(int temperature) {
    if (temperature >= 35) return 'Trời rất nóng, nhớ uống đủ nước';
    if (temperature >= 30) return 'Trời nóng, nhớ che nắng nhé';
    if (temperature >= 25) return 'Thời tiết khá ấm áp';
    if (temperature >= 18) return 'Thời tiết mát mẻ';
    return 'Trời se lạnh, nhớ mang áo khoác';
  }
}
