import 'package:flutter/material.dart';

class NormalPressure extends StatefulWidget {
  const NormalPressure({Key? key}) : super(key: key);

  @override
  State<NormalPressure> createState() => _NormalPressureState();
}

class _NormalPressureState extends State<NormalPressure> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3a73b5),
        title: Text('บันทึกผลสำเร็จ'),
      ),
      body: Center(
          child: Column(
        children: [
          Image(image: AssetImage('assets/image/normal_pressure_edit.png')),
          ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  textStyle:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              child: const Text('ตกลง')),
        ],
      )),
      backgroundColor: Color.fromARGB(255, 239, 214, 215),
    );
  }
}
