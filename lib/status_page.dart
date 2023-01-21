import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  final List<CarbonEmsissionData> chartData = [
    CarbonEmsissionData(1, 500, Colors.red),
    CarbonEmsissionData(2, 2000, Colors.blue),
    CarbonEmsissionData(3, 400, Colors.green),
    CarbonEmsissionData(4, 1000, Colors.yellow)
  ];
  dynamic emissions = 1000000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('greenifyTransit'),
        /* automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          )*/
      ),
      body: Column(
        children: [
          Container(
            color: Colors.green,
            margin: const EdgeInsets.all(30),
            child: Column(
              children: [
                const Text(
                  'Total CO2 emissions this month',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                Row(
                  children: [
                    Text('$emissions',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 80,
                        )),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 300,
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
          ElevatedButton(
            onPressed: () {},
            child: const Text('Purchase Carbon credits'),
          )
        ],
      ),
    );
  }
}

class CarbonEmsissionData {
  final int weeks;
  final double carbonEmisions;
  final Color color;

  CarbonEmsissionData(this.weeks, this.carbonEmisions, this.color);
}
