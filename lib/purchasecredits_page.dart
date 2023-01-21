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
        body: SingleChildScrollView());
  }
}
