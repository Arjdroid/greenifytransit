import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String cTyp = 'petrol';
  String cCls = 'suv';
  var items = ['petrol', 'diesel', 'hybrid'];
  var itemsC = ['suv', 'sedan', 'hutch'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 214, 247, 246),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: const EdgeInsets.fromLTRB(5, 50, 150, 1),
            width: 200,
            height: 30,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 115, 226, 119),
                borderRadius: BorderRadius.circular(15)),
            child: const Text(
              'Select your car type',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 140, vertical: 10),
            child: DropdownButton(
              style: TextStyle(fontSize: 20, color: Colors.green),
              value: cTyp,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  cTyp = newValue!;
                });
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(5, 30, 150, 1),
            width: 200,
            height: 30,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 115, 226, 119),
                borderRadius: BorderRadius.circular(15)),
            child: const Text(
              'Select your car kind',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 140, vertical: 10),
            child: DropdownButton(
              style: TextStyle(fontSize: 20, color: Colors.green),
              value: cCls,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: itemsC.map((String itemsC) {
                return DropdownMenuItem(
                  value: itemsC,
                  child: Text(itemsC),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  cCls = newValue!;
                });
              },
            ),
          ),
        ]),
      ),
    );
  }
}
