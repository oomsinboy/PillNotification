import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AvgPage extends StatefulWidget {
  // const AvgPage({Key? key}) : super(key: key);

  @override
  State<AvgPage> createState() => _AvgPageState();
  late User user;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _getPressure() async {

    user = _auth.currentUser!;
  }
}

class _AvgPageState extends State<AvgPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ค่าเฉลี่ยความดันโลหิต")),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              // bottom: 20.0,
              top: 10,
            ),
            child: Text('TEST')),
      ),
    );
  }
}
