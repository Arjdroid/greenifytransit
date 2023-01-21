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
  //List modes = ['walking', 'bicycling', 'transit', 'driving'];
  String tMode = 'bicycling';
  int duration = 0;
  int distance = 0;
  //List carTypes = ['petrol', 'diesel', 'hybrid', 'ev']
  // diesel cars emit only 80% emissions of avg. car
  // hybrids emit only 60% emissions of avg.car
  // evs emit 0 emissions
  // Source: https://www.lightfoot.co.uk/news/2017/10/04/how-much-co2-does-a-car-emit-per-year/
  String cTyp = 'petrol';
  //List carTypes = ['suv', 'sedan', 'hatch']
  // SUV emits 14% more than hatch, Sedan emits 5% more
  // Source: https://www.theguardian.com/us-news/2020/sep/01/suv-conquered-america-climate-change-emissions
  String cCls = 'suv';
  // Carbon Emissions
  int emissions = 0;

  // Function that makes the Distance Matrix API CAll
  void getDistanceMatrix(
      originLat, originLng, destLat, destLng, mode, key) async {
    String baseURL = 'https://maps.googleapis.com/maps/api/distancematrix/json';
    String request =
        '$baseURL?origins=$originLat,$originLng&destinations=$destLat,$destLng&mode=$mode&units=metric&key=$key';
    //print(request); // For Debug
    var response = await http.get(Uri.parse(request));
    var jsonString = response.body.toString();
    var data = jsonDecode(jsonString);
    //print('$response');
    if (response.statusCode == 200) {
      //print('Request Successfull!'); // For Debug
      setState(() {
        duration =
            data['rows'][0]['elements'][0]['duration']['value']; // Seconds
        distance =
            data['rows'][0]['elements'][0]['distance']['value']; // Meters
      });
      //print('$duration');
    } else {
      throw Exception('Failed To Call API');
    }
  }

  // Function that calculates the Carbon Emissions of A Journey
  void getCarbonEmissions(duration, mode, carType, carClass) async {
    // Source: https://www.eea.europa.eu/highlights/average-co2-emissions-from-new-cars-vans-2019
    // Average car emits 122.4 grams of CO2 per kilometre
    if (mode == 'walking') {
      var modeIndex = 0;
    } else if (mode == 'bicycling') {
      var modeIndex = 1;
    } else if (mode == 'transit') {
      var modeIndex = 2;
    } else if (mode == 'driving') {
      var modeIndex = 3;
    }
    ;
    var baseCarEmission = distance * 122.4 * 0.001;
    //if (mode ) {}
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
            Text(' '),
            Text('Origin LatLng: $oLat, $oLng'),
            Text('Dest. LatLng: $dLat, $dLng'),
            Text(' '),
            //Text('Mode: ' + modes.elementAt(0)),
            Text('Mode: $tMode'),
            Text(' '),
            //Text('$distMatrixKey'),
            Text('Travel Time: $duration seconds'),
            Text('Distance: $distance meters'),
            Text(' '),
            Text('Car Type: $cTyp'),
            Text('Car Class: $cCls'),
            Text(' '),
            Text('Trip Emissions: kg'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getDistanceMatrix(oLat, oLng, dLat, dLng, tMode, distMatrixKey);
          getCarbonEmissions(duration, tMode, cTyp, cCls);
        },
        child: const Icon(Icons.filter_center_focus_outlined),
      ),
    );
  }
}
