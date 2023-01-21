import 'package:flutter/material.dart';

class SocialsPage extends StatefulWidget {
  const SocialsPage({super.key});

  @override
  State<SocialsPage> createState() => _SocialsPageState();
}

class _SocialsPageState extends State<SocialsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Socials page'),
        ),
        body: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text('User\'s name ',
                style: TextStyle(fontSize: 16), textAlign: TextAlign.left),
          ],
        ));
  }
}
