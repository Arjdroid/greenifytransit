import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SocialsPage extends StatefulWidget {
  const SocialsPage({super.key});

  @override
  State<SocialsPage> createState() => _SocialsPageState();
}

class _SocialsPageState extends State<SocialsPage> {
  final List<CarbonEmsissionData> chartData = [
    CarbonEmsissionData(1, 500, Colors.red),
    CarbonEmsissionData(2, 2000, Colors.blue),
    CarbonEmsissionData(3, 400, Colors.green),
    CarbonEmsissionData(4, 1000, Colors.yellow)
  ];

  var text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Socials page'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Row(
            children: const [Text(' ')],
          ), //Empty row

          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your full name',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),

          Row(
            children: const [Text(' ')],
          ), //empty row

          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your location - City, State, Country',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }

              return null;
            },
          ),

          Row(
            children: const [Text(' ')],
          ), //empty row

          Container(
            height: 50,
            width: 200,
            color: Colors.blueGrey,
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  ' 10 following',
                  style: TextStyle(color: Colors.white),
                ),
                const Text(
                  ' -- ',
                  style: TextStyle(color: Colors.white),
                ),
                const Text(
                  '20 followers',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          Row(
            children: const [Text(' ')],
          ), //empty row

          Row(
            children: const [Text(' Statistics: ')],
          ),

          Row(
            children: const [Text(' ')],
          ), //empty row

          Container(
            height: 200,
            width: 200,
            child: SfCartesianChart(
              title: ChartTitle(text: 'carbon emssions saved this month'),
              series: <ChartSeries>[
                LineSeries<CarbonEmsissionData, int>(
                    pointColorMapper:
                        (CarbonEmsissionData carbonEmissions, _) =>
                            carbonEmissions.color,
                    dataSource: chartData,
                    xValueMapper: (CarbonEmsissionData carbonEmissions, _) =>
                        carbonEmissions.weeks,
                    yValueMapper: (CarbonEmsissionData carbonEmissions, _) =>
                        carbonEmissions.carbonEmisions)
              ],
            ),
          ),

          Row(
            children: const [Text(' ')],
          ), //empty row

          Row(
            children: const [
              Text(' Friends: ', style: TextStyle(color: Colors.deepOrange))
            ],
          ),

          Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.account_circle), onPressed: () => {}), iconSize: 50,
              IconButton(
                  icon: const Icon(Icons.account_circle), onPressed: () => {}),
              IconButton(
                  icon: const Icon(Icons.account_circle), onPressed: () => {})
            ],
          )
        ],
      )),
    );
  }
}

class CarbonEmsissionData {
  final int weeks;
  final double carbonEmisions;
  final Color color;

  CarbonEmsissionData(this.weeks, this.carbonEmisions, this.color);
}
