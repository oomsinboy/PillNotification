import 'package:flutter/material.dart';
import 'package:flutter_application_1/Navigation/navigation_drawer.dart';

class Historydrug extends StatefulWidget {
  @override
  _HistorydrugState createState() => _HistorydrugState();
}

class _HistorydrugState extends State<Historydrug> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerTest(),
      appBar: AppBar(
        backgroundColor: Color(0xFF3a73b5),
        title: Text('ประวัติการทานยา'),
      ),
      body: Center(
        child: Text(''),
      ),
      //backgroundColor: Color(0xFF73AEF5)
    );
  }
}
