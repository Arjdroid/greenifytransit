import 'package:flutter/material.dart';
import 'package:greenifytransitcodefest/status_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  /* List<Widget> pages = const [
    SocialsPage(),
    RoutesPlanner(),
    StatusPage(),
  ];
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const StatusPage(),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.route,
              color: Colors.green,
            ),
            label: 'Status',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.alt_route,
              color: Colors.green,
            ),
            label: 'Routes',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person,
              color: Colors.green,
            ),
            label: 'profile',
          ),
        ],
        /*  onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
        */
      ),
    );
  }
}
