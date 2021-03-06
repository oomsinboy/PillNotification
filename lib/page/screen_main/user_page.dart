import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user_model.dart';

import 'user_form.dart';

class PageDataUser extends StatefulWidget {
  const PageDataUser({Key? key}) : super(key: key);

  @override
  _PageDataUserState createState() => _PageDataUserState();
}

class _PageDataUserState extends State<PageDataUser> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  UserModel userModel = new UserModel();

  Future<void> _getUser() async {
    user = _auth.currentUser!;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((value) {
      setState(() {
        userModel = UserModel.fromMap(value.data());
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลผู้ใช้งาน'),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context)
                  .pushNamed(UserFormScreen.routeName)
                  .whenComplete(() => _getUser()),
              icon: Icon(Icons.edit))
        ],
      ),
      body: SafeArea(
          child: ListView(
        children: [
          SizedBox(height: 15),
          ClipOval(
            child: Image(
                image: AssetImage('assets/image/icon_sample_user.png'),
                height: 88),
          ),
          SizedBox(height: 25),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            padding: EdgeInsets.only(left: 20),
            height: MediaQuery.of(context).size.height / 15,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blueGrey[50],
            ),
            alignment: Alignment.center,
            child: (Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${userModel.firstName}',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                ),
              ],
            )),
          ),
          SizedBox(height: 25),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            padding: EdgeInsets.only(left: 20),
            height: MediaQuery.of(context).size.height / 7,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blueGrey[50],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 27,
                        width: 27,
                        color: Colors.blueAccent,
                        child: Icon(
                          Icons.mail,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Email : ${userModel.email}')
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 27,
                        width: 27,
                        color: Colors.blueAccent,
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'latest : ' + '${userModel.date}',
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            padding: EdgeInsets.only(left: 20),
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blueGrey[50],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 27,
                        width: 27,
                        color: Colors.blueAccent,
                        child: Icon(
                          Icons.lock,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Number HN : ${userModel.numberHN}'),
                    // getHN()
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 27,
                        width: 27,
                        color: Colors.blueAccent,
                        child: Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    userModel.address == 'null'
                        ? Text('ที่อยู่ : ไม่มีข้อมูล')
                        : Text('ที่อยู่ : ${userModel.address}')
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 27,
                        width: 27,
                        color: Colors.blueAccent,
                        child: Icon(
                          Icons.description,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    userModel.congenitalDisease == ''
                        ? Text(
                            'โรคประจำตัว : ไม่มีข้อมูล',
                          )
                        : Text(
                            'โรคประจำตัว : ${userModel.congenitalDisease}',
                          )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 27,
                        width: 27,
                        color: Colors.blueAccent,
                        child: Icon(
                          Icons.medication,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    userModel.drugAllergy == ''
                        ? Text(
                            'การแพ้ยา : ไม่มีข้อมูล',
                          )
                        : Text(
                            'การแพ้ยา : ${userModel.drugAllergy}',
                          )
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget getHN() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        String userData = snapshot.data.toString();
        return Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 0, left: 10),
          child: Text(
            // ignore: unnecessary_null_comparison
            userData == null ? "ไม่ได้เพิ่ม" : userData,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.black54,
            ),
          ),
        );
      },
    );
  }
}
