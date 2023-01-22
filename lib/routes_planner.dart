// Starting the Routes Planner Stuff
// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';
import 'package:greenifytransitcodefest/globals.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';

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
  double oLat = 0.0;
  double oLng = 0.0;
  double dLat = 0.0;
  double dLng = 0.0;
  String originAddress = '';
  String destinAddress = '';
  //
  // DEMO COORDS 1
  //
  // This one is just one block so it'll say walking is the best way
  /*double oLat = 37.75754213760453;
  double oLng = -122.43768627187049;
  double dLat = 37.75923433988162;
  double dLng = -122.43573362376672;*/
  //
  // DEMO COORDS 2
  //
  // This one is a very long distance ~40+ km so it'll always say driving is best
  /*double oLat = 37.74144781559247;
  double oLng = -122.50524108120509;
  double dLat = 37.92185635671533;
  double dLng = -122.3790957425826;*/
  //
  // DEMO COORDS 3
  //
  // This one has different weather and timings, will suggest bike as best
  /*double oLat = 34.01223769135059;
  double oLng = -118.41844426456332;
  double dLat = 34.022624461162096;
  double dLng = -118.40059148190034;*/
  List modes = ['walking', 'bicycling', 'transit', 'driving'];
  String tMode = 'driving';
  int duration = 0;
  int distance = 0;
  //List<dynamic> rankedSuggestionsList = ['Submit First'];
  String suggestedModePlaceHolder = '';
  // diesel cars emit only 80% emissions of avg. car
  // hybrids emit only 60% emissions of avg.car
  // evs emit 0 emissions
  // Source: https://www.lightfoot.co.uk/news/2017/10/04/how-much-co2-does-a-car-emit-per-year/
  //String cTyp = 'hybrid';
  List carTypes = ['petrol', 'diesel', 'hybrid', 'ev'];
  // SUV emits 14% more than hatch, Sedan emits 5% more
  // Source: https://www.theguardian.com/us-news/2020/sep/01/suv-conquered-america-climate-change-emissions
  //String cCls = 'sedan';
  List carClasses = ['suv', 'sedan', 'hatch'];
  // Base Emissions (Assuming petrol hatchback car)
  double baseEmissions = 0;
  // Carbon Emissions (in grams)
  double emissions = 0;
  // Current Weather Condition (temporary standin for getWeatherCondition)
  // This means that the weather is clear, if false that means that the weather is not clear
  bool isWeatherClear = false;

  // Function that gives a ranked suggestions list
  Future<List> getRankedSuggestions() async {
    // Get allNeededData from getAllData()
    List<dynamic> allNeededData = await getAllData(isWeatherClear);
    List suggestedModes = [];
    // Actual suggestions algorithm coming into play now
    if (isWeatherClear == true) {
      if (allNeededData[0][1] <= 600) {
        // Walking is best when duration is under 10 minutes
        // Index 0 is the top choice then it goes in ascending order of CO2 emissions
        //print('Walking duration is under 601s');
        return suggestedModes = ['walking', 'bicycling', 'transit', 'driving'];
      } else if (allNeededData[1][1] <= 1200) {
        // When bicycling duration is under 20 minutes, its most preferable
        return suggestedModes = ['bicycling', 'walking', 'transit', 'driving'];
      } else if (cTyp == 'ev') {
        // If the car is an EV, its preferred for longer journeys as zero emissions but bike & walk are chosen before because excercise is important
        return suggestedModes = ['driving', 'transit', 'bicycling', 'walking'];
      } else if (allNeededData[2][1] <= 3600) {
        // Public transit is still convenient when its under 1 hour
        return suggestedModes = ['transit', 'driving', 'bicycling', 'walking'];
      } else {
        // If even public transit is taking over an hour, cars are preferred as that is the tipping point of comfort & convenience
        return suggestedModes = ['driving', 'transit', 'bicycling', 'walking'];
      }
      //return suggestedModes = []; // Dart can be weird sometimes
    } else if (isWeatherClear == false) {
      if (allNeededData[0][1] <= 3600) {
        // Transit is bearable under one hour even when its raining
        //print(allNeededData[0][1]);
        return suggestedModes = ['transit', 'driving'];
      } else {
        // Beyond one hour of public transit, driving is preferable
        //print(allNeededData[0][1]);
        return suggestedModes = ['driving', 'transit'];
      }
    } else {
      throw Exception('Error');
    }
  }

  // Function that aggregates data for suggestions
  Future<List> getAllData(weatherClarity) async {
    // Consider whether the weather is clear or not
    if (weatherClarity == true) {
      // All modes of transport applicable
      List<String> availableModes = [
        'walking',
        'bicycling',
        'transit',
        'driving'
      ];
      // Manually iterate through each mode to eliminate randomness in output order
      List<Future<dynamic>> suggestionsData = [
        getDistanceMatrix(
            oLat, oLng, dLat, dLng, availableModes[0], distMatrixKey),
        getDistanceMatrix(
            oLat, oLng, dLat, dLng, availableModes[1], distMatrixKey),
        getDistanceMatrix(
            oLat, oLng, dLat, dLng, availableModes[2], distMatrixKey),
        getDistanceMatrix(
            oLat, oLng, dLat, dLng, availableModes[3], distMatrixKey),
      ];
      List<dynamic> resultingData = await Future.wait(suggestionsData);
      //print('RESULTING DATA: $resultingData');
      return resultingData;
      // Debug
      //print('Weather is clear'); //, available modes are: $availableModes');
    } else if (weatherClarity == false) {
      // Only Driving and Transit available as viable modes of Transport
      List<String> availableModes = ['transit', 'driving'];
      // Manually iterate through each mode in order to eliminate randonmness
      List<Future<dynamic>> suggestionsData = [
        getDistanceMatrix(
            oLat, oLng, dLat, dLng, availableModes[0], distMatrixKey),
        getDistanceMatrix(
            oLat, oLng, dLat, dLng, availableModes[1], distMatrixKey),
      ];
      List<dynamic> resultingData = await Future.wait(suggestionsData);
      //print('RESULTING DATA: $resultingData');
      return resultingData;
      // Debug
      //print('Weather is not clear, available modes are: $availableMode');
    } else {
      throw Exception('Failure');
    }
  }

  // Function that checks the weather for the Average between the 2 Coordinates
  Future<bool> getWeatherCondition(
      originLat, originLng, destLat, destLng, key) async {
    // Get the mean latitude and longitude to check the weather of
    var averageLat = (originLat + destLat) / 2;
    var averageLng = (originLng + originLng) / 2;
    // Debug
    //print("Average LatLng is $averageLat,$averageLng");
    // Make the weather API Call (bruh Google deprecated everything for this so I gotta sail out into the unknown)
    // Possible values for weatherMain that can come from the API
    // "Thunderstorm" "Drizzle" "Rain" "Snow" "Clear" "Clouds" "Mist" "Smoke" "Haze" "Dust" "Fog" "Sand" "Ash" "Squall" "Tornado"
    // We will say that isWeatherClear is true if weatherMain is either Clear, Clouds, or Mist
    String baseURL = 'https://api.openweathermap.org/data/2.5/weather';
    String request = '$baseURL?lat=$averageLat&lon=$averageLng&appid=$key';
    var response = await http.get(Uri.parse(request));
    var jsonString = response.body.toString();
    var data = jsonDecode(jsonString);
    if (response.statusCode == 200) {
      var weatherMain = data['weather'][0]['main'];
      print('WEATHER TYPE: $weatherMain');
      if (weatherMain == 'Clear') {
        return true;
      } else if (weatherMain == 'Clouds') {
        return true;
      } else if (weatherMain == 'Mist') {
        return true;
      } else
        return false;
    } else {
      throw Exception('Failed to call API');
    }
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
      //print('$iterativeData');
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
      }
    } // End of IF DRIVING
    throw Exception('God Damn This');
  } // I'm sorry to whoever has to review & read this, primarily myself

  final TextEditingController originController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  /*String? originLatitde;
  String? originLongitude;
  String? destinationLatitude;
  String? destinationLongitude;*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 214, 247, 246),
      appBar: AppBar(
        elevation: 0,
        title: Text('Route Planner'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                  height: 60,
                  width: 200,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: Column(children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Origin',
                        hintText: 'Starting Place',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }

                        return null;
                      },
                      controller: originController,
                      keyboardType: TextInputType.name,
                      onSaved: (value) {
                        originController.text = value!;
                      },
                      textInputAction: TextInputAction.done,
                    ),
                  ])),
              const SizedBox(
                height: 20,
              ),
              Container(
                  height: 60,
                  width: 200,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: Column(children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Destination',
                        hintText: 'Destination Place',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }

                        return null;
                      },
                      controller: destinationController,
                      keyboardType: TextInputType.name,
                      onSaved: (value) {
                        destinationController.text = value!;
                      },
                      textInputAction: TextInputAction.done,
                    ),
                  ])),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    setState(() {
                      originAddress = originController.text;
                      destinAddress = destinationController.text;

                      // Debug
                      print('$originAddress');
                      print('$destinAddress');
                    });
                  },
                  child: const Text('Submit'),
                ),
              ),
              Text('Suggested Mode = $suggestedModePlaceHolder'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Convert origin name to origin coords
          List<Location> originLocations =
              await locationFromAddress("$originAddress");
          List<Location> destinLocations =
              await locationFromAddress("$destinAddress");
          // debug
          /*print(
              '${originLocations.last.latitude} ${originLocations.last.longitude}');
          print(
              '${destinLocations.last.latitude} ${destinLocations.last.longitude}');*/
          setState(() {
            oLat = originLocations.last.latitude;
            oLng = originLocations.last.longitude;
            dLat = destinLocations.last.latitude;
            dLng = destinLocations.last.longitude;
          });
          // Get Weather Conditions
          isWeatherClear = await getWeatherCondition(
              oLat, oLng, dLat, dLng, openWeatherMapKey);
          List<dynamic> rankedSuggestionsList = await getRankedSuggestions();
          //getDistanceMatrix(oLat, oLng, dLat, dLng, tMode, distMatrixKey);
          //getCarbonEmissions(duration, tMode, cTyp, cCls);
          //getWeatherCondition(oLat, oLng, dLat, dLng, openWeatherMapKey);
          /*setState(() async {
            rankedSuggestionsList = await getRankedSuggestions();
          });*/
          print('RANKED SUGGESTIONS LIST: $rankedSuggestionsList');
          setState(() {
            suggestedModePlaceHolder = rankedSuggestionsList[0];
          });
          //bool tempWeatherClearTest = await getWeatherCondition(
          //    oLat, oLng, dLat, dLng, openWeatherMapKey);
          //print('TempWeatherCleart Test: $tempWeatherClearTest');
        },
        child: const Icon(Icons.filter_center_focus_outlined),
      ),
    );
  }
}
