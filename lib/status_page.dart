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
    CarbonEmsissionData(3, 400, Colors.white),
    CarbonEmsissionData(4, 1000, Colors.yellow)
  ];
  dynamic emissions = 1000000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: SingleChildScrollView(
        child: Column(
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
                              fontFamily: 'arial')),
                    ],
                  )
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0.1, 25, 0.1, 25),
                  width: 150,
                  height: 250,
                  alignment: Alignment.centerLeft,
                  color: const Color.fromARGB(255, 115, 226, 119),
                  child: SfCartesianChart(
                    title: ChartTitle(
                        text: 'carbon emssions saved this month',
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                        )),
                    series: <ChartSeries>[
                      LineSeries<CarbonEmsissionData, int>(
                          pointColorMapper:
                              (CarbonEmsissionData carbonEmissions, _) =>
                                  carbonEmissions.color,
                          dataSource: chartData,
                          xValueMapper:
                              (CarbonEmsissionData carbonEmissions, _) =>
                                  carbonEmissions.weeks,
                          yValueMapper:
                              (CarbonEmsissionData carbonEmissions, _) =>
                                  carbonEmissions.carbonEmisions)
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(90, 25, 2.5, 25),
                  width: 150,
                  height: 250,
                  alignment: Alignment.centerLeft,
                  color: const Color.fromARGB(255, 115, 226, 119),
                  child: SfCartesianChart(
                    title: ChartTitle(
                        text: 'carbon emssions saved this month',
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                        )),
                    series: <ChartSeries>[
                      LineSeries<CarbonEmsissionData, int>(
                          pointColorMapper:
                              (CarbonEmsissionData carbonEmissions, _) =>
                                  carbonEmissions.color,
                          dataSource: chartData,
                          xValueMapper:
                              (CarbonEmsissionData carbonEmissions, _) =>
                                  carbonEmissions.weeks,
                          yValueMapper:
                              (CarbonEmsissionData carbonEmissions, _) =>
                                  carbonEmissions.carbonEmisions)
                    ],
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Purchase Carbon credits'),
            )
          ],
        ),
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
