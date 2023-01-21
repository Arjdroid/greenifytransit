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
      List availableModes = ['walking', 'bicycling', 'transit', 'driving'];
      // Debug
      print('Weather is clear, available modes are: $availableModes');
    } else if (weatherClarity == false) {
      // Only Driving and Transit available as viable modes of Transport
      List availableMode = ['transit', 'driving'];
      // Debug
      print('Weather is not clear, available modes are: $availableMode');
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
        getCarbonEmissions(tMode, cTyp, cCls);
      });
      //print('$duration');
    } else {
      throw Exception('Failed To Call API');
    }
  }

  // Function that calculates the Carbon Emissions of A Journey
  void getCarbonEmissions(mode, carType, carClass) async {
    // Source: https://www.eea.europa.eu/highlights/average-co2-emissions-from-new-cars-vans-2019
    // Average car emits 122.4 grams of CO2 per kilometre
    /*var modeIndex = 0;
    if (mode == 'walking') {
      var modeIndex = 0;
    } else if (mode == 'bicycling') {
      var modeIndex = 1;
    } else if (mode == 'transit') {
      var modeIndex = 2;
    } else if (mode == 'driving') {
      var modeIndex = 3;
    }*/
    ;
    var baseCarEmission = distance * 122.4 * 0.001;
    double baseTypeEmission = 0;
    /*setState(() {
      //emissions = baseCarEmission;
    });*/
    if (mode == 'walking') {
      setState(() {
        emissions = 0;
        // Debug
        debugstatement = 'ZERO EMISSIONS WALK';
        baseEmissions = baseCarEmission;
      });
    } else if (mode == 'bicycling') {
      setState(() {
        emissions = 0;
        // Debug
        debugstatement = 'ZERO EMISSIONS BICYCLE';
        baseEmissions = baseCarEmission;
      });
    } else if (mode == 'transit') {
      setState(() {
        emissions = baseCarEmission * 0.10;
        // Debug
        debugstatement = 'TRANSIT EMISSIONS NEED REFINEMENT';
        baseEmissions = baseCarEmission;
      });
    } else if (mode == 'driving') {
      // Nest conditions for car types
      if (carType == 'ev') {
        setState(() {
          emissions = 0;
          // Debug
          debugstatement = 'ZERO EMISSIONS EV';
          baseEmissions = baseCarEmission;
        }); // EV is always 0 emissions
      } else if (carType == 'petrol') {
        // Nest car types
        if (carClass == 'hatch') {
          setState(() {
            emissions = baseCarEmission;
            // Debug
            debugstatement = 'SAME AS BASE EMISSIONS';
            baseEmissions = baseCarEmission;
          });
        } else if (carClass == 'sedan') {
          setState(() {
            emissions = baseCarEmission * 1.05;
            // Debug
            debugstatement = 'Sedan * 1.05';
            baseEmissions = baseCarEmission;
          });
        } else if (carClass == 'suv') {
          setState(() {
            emissions = baseCarEmission * 1.14;
            debugstatement = 'SUV is base * 1.14';
            baseEmissions = baseCarEmission;
          });
        } // Done with all Petrol Cases
      } else if (carType == 'diesel') {
        // What have I done
        setState(() {
          emissions = baseCarEmission * 0.8;
          // Debug
          debugstatement = 'base * 0.6';
          baseEmissions = baseCarEmission;
        });
      } else if (carClass == 'sedan') {
        setState(() {
          emissions = baseCarEmission * 1.05 * 0.8;
          // Debug
          debugstatement = 'base * 1.05 * 0.6';
          baseEmissions = baseCarEmission;
        });
      } else if (carClass == 'suv') {
        setState(() {
          emissions = baseCarEmission * 1.14 * 0.8;
          debugstatement = 'base * 1.14 * 0.6';
          baseEmissions = baseCarEmission;
        }); // Done with all Diesel Cases
      } else if (carType == 'hybrid') {
        // What have I done
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
        });
      } // Done with all Hybrid Cases
    } // End of IF DRIVING
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
            Text('Mode: $tMode'),
            Text(' '),
            //Text('$distMatrixKey'),
            Text('Travel Time: $duration seconds'),
            Text('Distance: $distance meters'),
            Text(' '),
            Text('Car Type: $cTyp'),
            Text('Car Class: $cCls'),
            Text(' '),
            Text('Trip Emissions: $emissions g'),
            Text(' '),
            Text('Debug Statement: $debugstatement'),
            Text('Debug Base Emissions (Petrol Hatch Car): $baseEmissions g'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getDistanceMatrix(oLat, oLng, dLat, dLng, tMode, distMatrixKey);
          //getCarbonEmissions(duration, tMode, cTyp, cCls);
          //getWeatherCondition(oLat, oLng, dLat, dLng, openWeatherMapKey);
          getSuggestions(isWeatherClear);
        },
        child: const Icon(Icons.filter_center_focus_outlined),
      ),
    );
  }
}
