import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WeatherCard extends StatelessWidget {
  final String city;
  final String temperature;
  final String mainCondition;

  WeatherCard({required this.city, required this.temperature, required this.mainCondition});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 200,
        color: Colors.amber[200],
        child: Row(
          children: [
            Padding(padding: EdgeInsets.all(10)),
            Text(city),
            Text(temperature),
            Text(mainCondition),
          ],
        )
      ),
    );
  }
}