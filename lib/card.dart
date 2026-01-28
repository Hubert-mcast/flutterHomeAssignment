import 'package:flutter/material.dart';

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
            Text(city),
            Text(temperature),
            Text(mainCondition),
          ],
        )
      ),
    );
  }
}