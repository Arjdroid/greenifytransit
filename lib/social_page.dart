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
      body: const Center(
          child: Text('User\'s name ',
              style: TextStyle(fontSize: 22), textAlign: TextAlign.left)),
    );
  }
}
