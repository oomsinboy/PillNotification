import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';

class UserLogin extends StatefulWidget {

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  TextEditingController ctrlHN = TextEditingController();

  void doLogin() {
    print(ctrlHN.text);

    if (ctrlHN.text == '12123') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

     body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.blue[300],
          ),
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          width: 150.0,
                          height: 150.0,
                          image: AssetImage('assets/image/medicine.png')),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                            child: Column(
                          children: [
                            TextFormField(
                              controller: ctrlHN,
                              keyboardType: TextInputType.numberWithOptions(),
                              decoration: InputDecoration(
                                  //prefixIcon: Icon(Icons.vpn_key),
                                  labelText: 'กรุณากรอกหมายเลข HN',
                                  labelStyle: TextStyle(fontSize: 15.0),
                                  filled: true,
                                  fillColor: Colors.white54),
                            ),
                          ],
                        )),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Material(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(const Radius.circular(30.0)),
                          // side: BorderSide(color: Colors.black)
                        ),
                        shadowColor: Colors.blue,
                        elevation: 5.0,
                        child: MaterialButton(
                          minWidth: 150.0,
                          height: 50.0,
                          onPressed: () => doLogin(),
                          //color: Colors.blue,
                          child: Text(
                            'ยืนยัน',
                            style: new TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.3),
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/forgot HN'),
                          child: Text('ไม่ทราบหมายเลข HN ?',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.0)))
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    
      
      
    );
  }
}