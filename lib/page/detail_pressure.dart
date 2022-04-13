import 'package:flutter/material.dart';

class DetailPressure extends StatefulWidget {
  @override
  _DetailPressureState createState() => _DetailPressureState();
}

class _DetailPressureState extends State<DetailPressure> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3a73b5),
        title: Text('ความดันระดับไหนถึงผิดปกติ'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: Image(
              image: AssetImage('assets/image/pressure.png'),
            ),
          ),
        ],
      ),
    );
  }
}
