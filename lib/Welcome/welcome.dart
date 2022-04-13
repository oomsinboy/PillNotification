import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/login/loginMail/loginmail_screen.dart';
// ignore: unused_import
import 'package:flutter_application_1/login/userlogin.dart';
// ignore: unused_import

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: 3,
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(60),
                  child: Column(
                    children: [
                      Image.asset("assets/image/medicine.png", height: 300),
                      SizedBox(height: 20),
                      Text(
                        "แนะการใช้งาน",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "ยินดีต้อนรับเข้าสู่แอปพลิเคชันที่ สะดวก ง่าย และจะช่วยทำให้คุณทานยาได้ในเวลาที่เหมาะสม",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.all(50),
            width: double.infinity,
            child: FlatButton(
              child: Text(
                "เริ่มต้นการใช้งาน",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
