import 'package:flutter/material.dart';
import 'package:home_assignment/card.dart';
import 'package:home_assignment/service/weather_service.dart';
import 'package:home_assignment/models/weather_model.dart';
import 'package:home_assignment/pages/edit_locations.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _savedLocations = Hive.box('SavedLocations');
  final _weatherService = WeatherService('883efe2af8f24e4611d3f8b1af15d4f0');
  String cityName = '';
  String country = '';
  Weather? _weather;

  _fetchWeather(cityName, country) async{
    if(cityName == ''){
    cityName = await _weatherService.getCurrentCity();
    country = await _weatherService.getCurrentCountry();
    }

    try{
      final weather = await _weatherService.getWeather(cityName, country);
      setState(() {
        _weather = weather;
      });
    }
    catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather(cityName, country);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.all(50)),

          Text(_weather?.cityName??'Loading...'),
          Text('${_weather?.temperature.round()}°C'),
          Text(_weather?.mainCondition??''),

          Expanded(
            child: ListView.builder(
              itemCount: _savedLocations.length,
              itemBuilder: (context, index) {
                Map location = _savedLocations.getAt(index);
                _fetchWeather(location['city'], location['country']);
                return WeatherCard(city: location['city'], temperature: '${_weather?.temperature.round()}°C', mainCondition: _weather?.mainCondition??'',);                
              }
            ),
          ),

          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => EditLocations()),);
          }, child: Text('Edit Locations')),

          Padding(padding: EdgeInsets.all(50)),
        ],
      ),
    );
  }
}