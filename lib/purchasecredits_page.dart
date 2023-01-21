import 'package:flutter/material.dart';

class PurchaseCredists extends StatefulWidget {
  const PurchaseCredists({super.key});

  @override
  State<PurchaseCredists> createState() => _PurchaseCredistsState();
}

class _PurchaseCredistsState extends State<PurchaseCredists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('greenifyTransit'),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  color: Colors.green,
                  margin: const EdgeInsets.all(30),
                  child: Column(
                    children: const [
                      Text(
                        'Purchase Carbon credits',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}
