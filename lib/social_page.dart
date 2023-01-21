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
              children: const [Text(' ')],
            ), //Empty row

            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.black,
                width: 2,
              )),
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text('FirstName'),
                  const Text(' '),
                  const Text('LastName'),
                ],
              ), //Firstname and Lastname
            ),
            Row(
              children: const [Text(' ')],
            ), //empty row

            Row(
              children: const [
                // ignore: prefer_const_constructors
                Text('Location'),
              ],
            ), //Location
          ],
        ));
  }
}
