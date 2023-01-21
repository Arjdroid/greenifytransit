import 'package:flutter/material.dart';
import 'package:greenifytransitcodefest/purchasecredits_page.dart';
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
      backgroundColor: Color.fromARGB(255, 214, 247, 246),
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
              margin: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  const Text(
                    'Total CO2 emissions this month',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 214, 247, 246),
                      fontSize: 25,
                    ),
                  ),
                  Row(
                    children: [
                      Text('$emissions',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 214, 247, 246),
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
                  margin: const EdgeInsets.fromLTRB(20, 25, 5, 25),
                  width: 150,
                  height: 250,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 115, 226, 119),
                      borderRadius: BorderRadius.circular(15)),
                  alignment: Alignment.centerLeft,
                  child: SfCartesianChart(
                    title: ChartTitle(
                        text: 'carbon emssions saved this month',
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 214, 247, 246),
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
                  margin: const EdgeInsets.fromLTRB(50, 25, 10, 25),
                  width: 150,
                  height: 250,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 115, 226, 119),
                      borderRadius: BorderRadius.circular(15)),
                  child: SfCartesianChart(
                    title: ChartTitle(
                        text: 'Total number of trips this month',
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 214, 247, 246),
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
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const PurchaseCredists();
                    },
                  ),
                );
              },
              child: const Text(
                'Purchase Carbon credits',
                style: TextStyle(
                  color: Color.fromARGB(255, 214, 247, 246),
                  fontSize: 15,
                ),
              ),
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
