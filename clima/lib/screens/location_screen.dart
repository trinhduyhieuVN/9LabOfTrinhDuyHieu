import 'package:flutter/material.dart';
import '../lab_ui.dart';
import '../services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, this.locationWeather});
  final dynamic locationWeather;
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final weather = WeatherModel();
  dynamic data;
  bool busy = false;
  String? error;
  @override
  void initState() {
    super.initState();
    data = widget.locationWeather;
    if (data == null) load();
  }

  Future<void> load([String? city]) async {
    setState(() {
      busy = true;
      error = null;
    });
    try {
      final result = await (city == null
          ? weather.getLocationWeather()
          : weather.getCityWeather(city));
      if (!mounted) return;
      if (result == null || result['main'] == null) {
        setState(
          () => error =
              'Chưa lấy được thời tiết. Hãy thử tên thành phố khác hoặc thử lại.',
        );
      } else {
        setState(() => data = result);
      }
    } catch (_) {
      if (!mounted) return;
      setState(
        () => error =
            'Không thể tải thời tiết. Kiểm tra kết nối hoặc tìm bằng tên thành phố.',
      );
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  Future<void> search() async {
    final city = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const CityScreen()),
    );
    if (!mounted || city == null) return;
    await load(city);
  }

  @override
  Widget build(BuildContext context) {
    final temperature =
        data == null ? null : (data['main']['temp'] as num).round();
    return LabPage(
      title: 'Clima',
      subtitle: 'Thời tiết hôm nay ở nơi bạn đến.',
      children: [
        LabCard(
          color: const Color(0xFFE5F2F5),
          child: Column(
            children: [
              Text(
                data == null ? 'Thời tiết hiện tại' : data['name'].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              if (busy)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                )
              else if (data != null) ...[
                Text(
                  weather.getWeatherIcon(data['weather'][0]['id'] as int),
                  style: const TextStyle(fontSize: 64),
                ),
                Text(
                  '$temperature°',
                  style: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  weather.getMessage(temperature!),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
              ] else
                const Icon(
                  Icons.cloud_outlined,
                  size: 80,
                  color: Color(0xFF147D73),
                ),
              if (error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    error!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF8D3434),
                      height: 1.5,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: busy ? null : search,
          icon: const Icon(Icons.search),
          label: const Text('Tìm thành phố'),
        ),
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: busy ? null : () => load(),
          icon: const Icon(Icons.my_location),
          label: const Text('Dùng vị trí hiện tại'),
        ),
      ],
    );
  }
}
