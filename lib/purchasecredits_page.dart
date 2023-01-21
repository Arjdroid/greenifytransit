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
      body: ElevatedButton(
        onPressed: () {},
        child: const Text('purchase credits'),
      ),
    );
  }
}
