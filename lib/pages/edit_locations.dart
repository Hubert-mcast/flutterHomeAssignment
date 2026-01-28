import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:home_assignment/service/notification_service.dart';

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
          MaterialButton( //save button
            onPressed: (){ 
              writeData();
              NotificationService().showNotification(title: 'Saved location', body: _city.text);
              Navigator.pop(context);
            },
            child: Text('Save'),
            color: Colors.blue,
          ),
          MaterialButton( //delete button
            onPressed: (){
            final box = Hive.box('SavedLocations');
            box.clear();
            NotificationService().showNotification(title: 'Deleted locations', body: 'deleted all locations');
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