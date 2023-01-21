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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Socials page'),
        ),
        body: Column(
          children: [
            Row(
              children: const [Text(' ')],
            ), //Empty row

            Container(
              height: 50,
              width: 200,
              color: Colors.blueGrey,

              child: Row(
                // ignore: prefer_const_literals_to_create_immutables

                children: const [
                  Text(
                    ' FirstName',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(' '),
                  Text(
                    ' LastName',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ), //Firstname and Lastname
            ), //Name container
            Row(
              children: const [Text(' ')],
            ), //empty row

            Container(
              height: 50,
              width: 200,
              color: Colors.blueGrey,
              child: Row(
                children: const [
                  // ignore: prefer_const_constructors
                  Text(
                    ' Location - City, State, Country',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
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
          ],
        ));
  }
}

class CarbonEmsissionData {
  final int weeks;
  final double carbonEmisions;
  final Color color;

  CarbonEmsissionData(this.weeks, this.carbonEmisions, this.color);
}
