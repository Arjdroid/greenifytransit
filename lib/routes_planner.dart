// Starting the Routes Planner Stuff
// ignore_for_file: prefer_const_constructors, avoid_print

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
  // MOST of these should move to globals.dart and or just rely on user input.
  String debugstatement = '';
  // Defining the distance matrix parameters
  double oLat = 37.74144781559247;
  double oLng = -122.50524108120509;
  double dLat = 37.92185635671533;
  double dLng = -122.3790957425826;
  List modes = ['walking', 'bicycling', 'transit', 'driving'];
  String tMode = 'driving';
  int duration = 0;
  int distance = 0;
  // diesel cars emit only 80% emissions of avg. car
  // hybrids emit only 60% emissions of avg.car
  // evs emit 0 emissions
  // Source: https://www.lightfoot.co.uk/news/2017/10/04/how-much-co2-does-a-car-emit-per-year/
  String cTyp = 'hybrid';
  List carTypes = ['petrol', 'diesel', 'hybrid', 'ev'];
  // SUV emits 14% more than hatch, Sedan emits 5% more
  // Source: https://www.theguardian.com/us-news/2020/sep/01/suv-conquered-america-climate-change-emissions
  String cCls = 'sedan';
  List carClasses = ['suv', 'sedan', 'hatch'];
  // Base Emissions (Assuming petrol hatchback car)
  double baseEmissions = 0;
  // Carbon Emissions (in grams)
  double emissions = 0;
  // Current Weather Condition (temporary standin for getWeatherCondition)
  // This means that the weather is clear, if false that means that the weather is not clear
  bool isWeatherClear = true;

  // Function that actually generates the suggestions
  void getSuggestions(
    weatherClarity,
  ) async {
    // Consider whether the weather is clear or not
    if (weatherClarity == true) {
      // All modes of transport applicable
      List<String> availableModes = [
        'walking',
        'bicycling',
        'transit',
        'driving'
      ];
      String availMode = '';
      // A for-in loop that goes through every available mode and extracts their travel times + carbon emissions
      for (availMode in availableModes) {
        //print('Mode: $availMode');
        // Call the getDistanceMatrix function
        Future<List> dataList =
            getDistanceMatrix(oLat, oLng, dLat, dLng, availMode, distMatrixKey);
        //print('Traval Duration: $duration s');
        //print(' ');
        //print('$dataList');
      }
      // Debug
      //print('Weather is clear'); //, available modes are: $availableModes');
    } else if (weatherClarity == false) {
      // Only Driving and Transit available as viable modes of Transport
      List<String> availableMode = ['transit', 'driving'];
      // Debug
      //print('Weather is not clear, available modes are: $availableMode');
    }
  }

  // Function that checks the weather for the Average between the 2 Coordinates
  void getWeatherCondition(originLat, originLng, destLat, destLng, key) async {
    // Get the mean latitude and longitude to check the weather of
    var averageLat = (originLat + destLat) / 2;
    var averageLng = (originLng + originLng) / 2;
    // Debug
    //print("Average LatLng is $averageLat,$averageLng");
    // Make the weather API Call (bruh Google deprecated everything for this so I gotta sail out into the unknown)
    // Open Weather Map Says it'll take 2 hours for my damn API key to activate but I'll create the request so that I don't have to wait for it later (around 11.50 rn)
    /*
    String baseURL = 'https://api.openweathermap.org/data/2.5/weather';
    String request = '$baseURL?lat=$averageLat&lon=$averageLng&appid=$key';
    var response = await http.get(Uri.parse(request));
    var jsonString = response.body.toString();
    var data = jsonDecode(jsonString);
    */
  }

  // Function that makes the Distance Matrix API CAll
  Future<List> getDistanceMatrix(
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
      var iterativeDuration =
          data['rows'][0]['elements'][0]['duration']['value']; // Seconds
      var iterativeDistance =
          data['rows'][0]['elements'][0]['distance']['value']; // Meters
      getCarbonEmissions(iterativeDistance, mode, cTyp, cCls);
      // Make a list of all the data
      List iterativeData = [
        mode,
        iterativeDuration,
        iterativeDistance,
        emissions
      ];
      print('$iterativeData');
      return iterativeData;
    } else {
      throw Exception('Failed To Call API');
    }
  }

  // Function that calculates the Carbon Emissions of A Journey
  Future<double> getCarbonEmissions(distance, mode, carType, carClass) async {
    // Source: https://www.eea.europa.eu/highlights/average-co2-emissions-from-new-cars-vans-2019
    // Average car emits 122.4 grams of CO2 per kilometre
    var baseCarEmission = distance * 122.4 * 0.001;
    /*setState(() {
      //emissions = baseCarEmission;
    });*/
    if (mode == 'walking') {
      //print('ZERO EMISSIONS WALK');
      return emissions = 0;
      // Debug
      //debugstatement = 'ZERO EMISSIONS WALK';
      //baseEmissions = baseCarEmission;
    } else if (mode == 'bicycling') {
      //print('ZERO EMISSIONS BICYCLE');
      return emissions = 0;
      // Debug
      //debugstatement = 'ZERO EMISSIONS BICYCLE';
      //baseEmissions = baseCarEmission;
    } else if (mode == 'transit') {
      //print('TRANSIT EMISSIONS ARE WEIRD: base = $baseCarEmission');
      return emissions = baseCarEmission * 0.10;
      // Debug
      //debugstatement = 'TRANSIT EMISSIONS NEED REFINEMENT';
      //baseEmissions = baseCarEmission;
    } else if (mode == 'driving') {
      // Nest conditions for car types
      if (carType == 'ev') {
        //print('ZERO EMISSIONS EV');
        return emissions = 0;
        // EV is always 0 emissions
      } else if (carType == 'petrol') {
        // Nest car classes
        if (carClass == 'hatch') {
          //print('SAME AS BASE EMISSIONS');
          return emissions = baseCarEmission;
        } else if (carClass == 'sedan') {
          //print('SEDAN is base * 1.05');
          return emissions = baseCarEmission * 1.05;
        } else if (carClass == 'suv') {
          //print('SUV is base * 1.14');
          return emissions = baseCarEmission * 1.14;
        } // Done with all Petrol Cases
        //
        // Moving to Diesel
        //
      } else if (carType == 'diesel') {
        // Nest car classes
        if (carClass == 'hatch') {
          //print('Diesel hatch is base * 0.8');
          return emissions = baseCarEmission * 0.8;
        } else if (carClass == 'sedan') {
          //print('Diesel SEDAN is base * 1.05 * 0.8');
          return emissions = baseCarEmission * 1.05 * 0.8;
        } else if (carClass == 'suv') {
          //print('Diesel SUV is base * 1.14 * 0.8');
          return emissions = baseCarEmission * 1.14 * 0.8;
        } // Done with all Diesel Cases
        //
        // Moving to Hybrids
        //
      } else if (carType == 'hybrid') {
        // Nest car classes
        if (carClass == 'hatch') {
          //print('Hybrid hatch is base * 0.6');
          return emissions = baseCarEmission * 0.6;
        } else if (carClass == 'sedan') {
          //print('Hybrid SEDAN is base * 1.05 * 0.6');
          return emissions = baseCarEmission * 1.05 * 0.6;
        } else if (carClass == 'suv') {
          //print('Hybrid SUV is base * 1.14 * 0.6');
          return emissions = baseCarEmission * 1.14 * 0.6;
        } // Done with all Hybrid Cases
        /*// What have I done
        setState(() {
          emissions = baseCarEmission * 0.6;
          // Debug
          debugstatement = 'base * 0.6';
          baseEmissions = baseCarEmission;
        });
      } else if (carClass == 'sedan') {
        setState(() {
          emissions = baseCarEmission * 1.05 * 0.6;
          // Debug
          debugstatement = 'base * 1.05 * 0.6';
          baseEmissions = baseCarEmission;
        });
      } else if (carClass == 'suv') {
        setState(() {
          emissions = baseCarEmission * 1.14 * 0.6;
          debugstatement = 'base * 1.14 * 0.6';
          baseEmissions = baseCarEmission;
        });*/
      } // Done with all Hybrid Cases
    } // End of IF DRIVING
    throw Exception('God Damn This');
  } // I'm sorry to whoever has to review & read this, primarily myself

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
            //Text('Mode: $tMode'),
            //Text(' '),
            //Text('$distMatrixKey'),
            //Text('Travel Time: $duration seconds'),
            //Text('Distance: $distance meters'),
            //Text(' '),
            Text('Car Type: $cTyp'),
            Text('Car Class: $cCls'),
            //Text(' '),
            //Text('Trip Emissions: $emissions g'),
            //Text(' '),
            //Text('Debug Statement: $debugstatement'),
            //Text('Debug Base Emissions (Petrol Hatch Car): $baseEmissions g'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //getDistanceMatrix(oLat, oLng, dLat, dLng, tMode, distMatrixKey);
          //getCarbonEmissions(duration, tMode, cTyp, cCls);
          //getWeatherCondition(oLat, oLng, dLat, dLng, openWeatherMapKey);
          getSuggestions(isWeatherClear);
        },
        child: const Icon(Icons.filter_center_focus_outlined),
      ),
    );
  }
}
