import 'package:flutter/material.dart';

class HighPressure extends StatefulWidget {
  const HighPressure({Key? key}) : super(key: key);

  @override
  State<HighPressure> createState() => _HighPressureState();
}

class _HighPressureState extends State<HighPressure> {
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
            Center(
              child: Image(image: AssetImage('assets/image/high_pressure.png')),
            ),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/dashboard'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    textStyle:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                child: const Text('ตกลง')),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 239, 214, 215),

      //  Center(
      //   child: Image(image: AssetImage('assets/image/high_pressure.png')),
      // ),
    );
  }
}
