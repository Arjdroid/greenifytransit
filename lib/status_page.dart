import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
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
              height: 200,
              width: 400,
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
              )),
        ],
      ),
    );
  }
}
