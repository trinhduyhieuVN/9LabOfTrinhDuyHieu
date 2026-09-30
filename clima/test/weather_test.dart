import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_vku_lab9/services/networking.dart';
import 'package:flutter_vku_lab9/services/weather.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

http.Response response(Object json) => http.Response.bytes(
      utf8.encode(jsonEncode(json)),
      200,
      headers: {'content-type': 'application/json; charset=utf-8'},
    );

void main() {
  test('Finds a city and maps current weather', () async {
    final client = MockClient((request) async {
      if (request.url.host == 'geocoding-api.open-meteo.com') {
        expect(request.url.queryParameters['name'], 'Da Nang');
        return response({
          'results': [
            {
              'name': 'Đà Nẵng',
              'admin1': 'Đà Nẵng',
              'country': 'Việt Nam',
              'latitude': 16.0544,
              'longitude': 108.2022,
            }
          ]
        });
      }
      expect(request.url.host, 'api.open-meteo.com');
      expect(request.url.queryParameters['current'],
          'temperature_2m,weather_code');
      return response({
        'current': {'temperature_2m': 28.4, 'weather_code': 2}
      });
    });
    final weather = WeatherModel(network: NetworkHelper(client: client));

    final result = await weather.getCityWeather('Da Nang');

    expect(result['name'], 'Đà Nẵng, Việt Nam');
    expect(result['main']['temp'], 28.4);
    expect(result['weather'][0]['id'], 2);
    client.close();
  });

  test('Explains when a city is not found', () async {
    final client = MockClient((_) async => response({'results': null}));
    final weather = WeatherModel(network: NetworkHelper(client: client));

    await expectLater(
      weather.getCityWeather('Unknown place'),
      throwsA(isA<WeatherException>()),
    );
    client.close();
  });
}
