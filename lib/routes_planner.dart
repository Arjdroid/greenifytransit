// Starting the Routes Planner Stuff
// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Variable Stores
import 'package:greenifytransitcodefest/api_keys.dart';
import 'package:greenifytransitcodefest/globals.dart';

class RoutesPlanner extends StatefulWidget {
  const RoutesPlanner({super.key});

  @override
  State<RoutesPlanner> createState() => _RoutesPlannerState();
}

class _RoutesPlannerState extends State<RoutesPlanner> {
  // Defining the distance matrix parameters
  String oLat = '37.74144781559247';
  String oLng = '-122.50524108120509';
  String dLat = '37.92185635671533';
  String dLng = '-122.3790957425826';
  String tMode = 'bicyling';
  String duration = '';
  //List modes = ['walking', 'bicycle', 'transit', 'driving'];
  /*
  String originLat = '';
  String originLng = '';
  String destLat = '';
  String destLng = '';
  String mode = '';*/

  // Function that makes the Distance Matrix API CAll
  void getDistanceMatrix(
      originLat, originLng, destLat, destLng, mode, key) async {
    String baseURL = 'https://maps.googleapis.com/maps/api/distancematrix/json';
    String request =
        '$baseURL?origins=$originLat,$originLng&destinations=$destLat,$destLng&mode=$mode&units=metric&key=$key';
    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print(data);
    if (response.statusCode == 200) {
      setState(() {
        //_placesList = jsonDecode(response.body.toString())['predictions'];
        duration = jsonDecode(data);
      });
    } else {
      throw Exception('Failed To Call API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Route Planner'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Distance Matrix Details'),
            Text('Origin LatLng: $oLat, $oLng'),
            Text('Dest. LatLng: $dLat, $dLng'),
            //Text('Mode: ' + modes.elementAt(0)),
            Text('Mode: $tMode'),
            //Text('$distMatrixKey'),
            Text('Travel Time:'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getDistanceMatrix(oLat, oLng, dLat, dLng, tMode, distMatrixKey);
        },
        child: const Icon(Icons.filter_center_focus_outlined),
      ),
    );
  }
}
