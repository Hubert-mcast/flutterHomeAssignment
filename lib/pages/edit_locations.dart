import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EditLocations extends StatefulWidget {
  const EditLocations({super.key});

  @override
  State<EditLocations> createState() => _EditLocationsState();
}

class _EditLocationsState extends State<EditLocations>{
  final _savedLocations = Hive.box('SavedLocations');
  final TextEditingController _city = TextEditingController();
  final TextEditingController _country = TextEditingController();

  void writeData(){
    _savedLocations.add({
      'city': _city.text,
      'country': _country.text,
    });
  }

  @override
  void dispose(){
    _city.dispose();
    _country.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(50)),
          TextField(controller: _city,decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Enter city name'),),
          TextField(controller: _country,decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Enter country code ex MT'),),
          MaterialButton(
            onPressed: (){ 
              writeData();
              Navigator.pop(context);
            },
            child: Text('Save'),
            color: Colors.blue,
          ),
          MaterialButton(onPressed: (){
            final box = Hive.box('SavedLocations');
            box.clear();
            Navigator.pop(context);
          }, 
          child: Text('Clear All'),
          color: Colors.red,
          )
        ],
      )
    );
  }
}