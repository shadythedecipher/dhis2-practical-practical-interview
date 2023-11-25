import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/WeatherData.dart';

class WeatherDetailsScreen extends StatelessWidget {
  final WeatherInformation weatherInfo;

  const WeatherDetailsScreen({Key? key, required this.weatherInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Coord'),
            _buildInfoRow('Lon', weatherInfo.coord?.lon?.toString() ?? ''),
            _buildInfoRow('Lat', weatherInfo.coord?.lat?.toString() ?? ''),
            SizedBox(height: 20),
            _buildSectionTitle('Weather'),
            if (weatherInfo.weather != null)
              Column(
                children: weatherInfo.weather!.map((w) {
                  return _buildInfoRow(
                      'Weather ${w?.id}', w?.description ?? '');
                }).toList(),
              ),
            _buildSectionTitle('Pressure/Humidity'),
            _buildInfoRow('Pressure', '${weatherInfo.main?.pressure ?? "-"} hPa'),
            _buildInfoRow('Humidity', '${weatherInfo.main?.humidity ?? "-"} %'),

            SizedBox(height: 20),
            _buildSectionTitle('Clouds'),
            _buildInfoRow('Cloudiness', '${weatherInfo.clouds?.all ?? "-"} %'),
            SizedBox(height: 20),
            _buildSectionTitle('Additional Information'),
            _buildInfoRow('Request Time', _formatDateTime(weatherInfo.dt) ?? "-"),
            _buildInfoRow('Sunrise', _formatDateTime(weatherInfo.sys?.sunrise) ?? "-"),
            _buildInfoRow('Sunset', _formatDateTime(weatherInfo.sys?.sunset) ?? "-"),
            SizedBox(height: 20),
            _buildSectionTitle('Other Details'),
            _buildInfoRow('Base', weatherInfo.base ?? ''),
            _buildInfoRow('Visibility', weatherInfo.visibility?.toString() ?? ''),
            _buildInfoRow('Timezone', weatherInfo.timezone?.toString() ?? ''),
            _buildInfoRow('ID', weatherInfo.id?.toString() ?? ''),
            _buildInfoRow('Name', weatherInfo.name ?? ''),
            _buildInfoRow('Country', weatherInfo.sys?.country ?? "-"),
            _buildInfoRow('Cod', weatherInfo.cod?.toString() ?? ''),
            SizedBox(height: 20),
            // Add more sections for other classes like Main, Wind, Clouds, Sys if needed
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
  // String _formatDateTime(String? timestamp) {
  //   if (timestamp != null && timestamp != '-') {
  //     DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
  //     // You can customize the date and time format as needed using DateFormat
  //     // For example, using intl package: https://pub.dev/packages/intl
  //     // Import 'package:intl/intl.dart'; at the beginning of your file
  //     // Example format: DateFormat.yMd().add_jm().format(dateTime)
  //     return DateFormat.yMd().add_jm().format(dateTime);
  //   } else {
  //     return '-';
  //   }
  // }

  String _formatDateTime(int? timestamp) {
    if (timestamp != null) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      return DateFormat.yMd().add_jm().format(dateTime);
    } else {
      return '-';
    }
  }
  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
