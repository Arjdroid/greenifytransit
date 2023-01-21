import 'package:flutter/material.dart';

class PurchaseCredists extends StatefulWidget {
  const PurchaseCredists({super.key});

  @override
  State<PurchaseCredists> createState() => _PurchaseCredistsState();
}

class _PurchaseCredistsState extends State<PurchaseCredists> {
  bool isSwitch = false;
  bool isSwitch2 = false;
  bool isSwitch3 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 214, 247, 246),
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
              const Text(
                'Purchase Carbon Credits',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 50,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    const Text(
                      'Your total emissions',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    Row(
                      children: const [
                        Text('1000000',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 80,
                                fontFamily: 'arial')),
                      ],
                    )
                  ],
                ),
              ),
              const Text(
                'Choose your prefered scheme',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 50,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(30),
                width: 330,
                height: 120,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    const Text(
                      'Planting trees in Canada',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        Text('Price:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: 'arial')),
                      ],
                    ),
                    Switch(
                        value: isSwitch,
                        activeColor: Colors.blue,
                        onChanged: (bool newBool) {
                          setState(() {
                            isSwitch = newBool;
                          });
                        }),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(30),
                width: 330,
                height: 120,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    const Text(
                      'Scheme 2',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        Text('Price:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: 'arial')),
                      ],
                    ),
                    Switch(
                        value: isSwitch2,
                        activeColor: Colors.blue,
                        onChanged: (bool newBool) {
                          setState(() {
                            isSwitch2 = newBool;
                          });
                        }),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(30),
                width: 330,
                height: 120,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    const Text(
                      'Scheme 3',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        Text('Price:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: 'arial')),
                      ],
                    ),
                    Switch(
                        value: isSwitch3,
                        activeColor: Colors.blue,
                        onChanged: (bool newBool) {
                          setState(() {
                            isSwitch3 = newBool;
                          });
                        }),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
