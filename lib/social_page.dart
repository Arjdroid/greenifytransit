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
          children: [
            Row(
              children: [
                Text('FirstName'),
                Spacer(),
                Text('LastName'),
              ],
            ),
            Row(
              children: [
                Text('Location'),
              ],
            )
          ],
          // ignore: prefer_const_literals_to_create_immutables
          /*children: [
              Row(
                children: [
                  // ignore: prefer_const_constructors
                  Text('User\'s name '),
                ],
              ),
            ]));*/
        ));
  }
}
