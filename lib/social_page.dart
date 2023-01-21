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
              color: Colors.black,

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
              color: Colors.black,
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
              color: Colors.black,
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
          ],
        ));
  }
}
