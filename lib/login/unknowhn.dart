import 'package:flutter/material.dart';

//กรณีผู้ใช้ไม่ทราบว่าเลข HN คืออะไร

class UnknowHN extends StatefulWidget {

  @override
  _UnknowHNState createState() => _UnknowHNState();
}

class _UnknowHNState extends State<UnknowHN> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('ไม่ทราบหมายเลข HN'),
        backgroundColor: Color(0xFF3a73b5),
      ),
      body: ListView(
        children: [
          Image(image: AssetImage('assets/image/Exhn.jpg')),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              '* กรุณาตรวจสอบหน้าซองยาของท่าน',
              style: TextStyle(fontSize: 15.2, color: Colors.red),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'กลับ',
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          )
        ],
      ),
      
    );
  }
}