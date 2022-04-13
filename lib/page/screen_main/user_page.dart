import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PageDataUser extends StatefulWidget {
  const PageDataUser({Key? key}) : super(key: key);

  @override
  _PageDataUserState createState() => _PageDataUserState();
}

class _PageDataUserState extends State<PageDataUser> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลผู้ใช้งาน'),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          SizedBox(height: 15),
          Container(
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/image/medicine.png'),
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  width: 5,
                ),
                shape: BoxShape.circle),
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
                  user.displayName!,
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
                    Text(
                      'Email : ' + user.email!,
                    ),
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
                      'User ID : ' + user.uid,
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
                    Text('Number HN : '),
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
                    Text(
                      'ที่อยู่ : ' + 'ไม่มีข้อมูล',
                    ),
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
                    Text(
                      'โรคประจำตัว : ' + 'ไม่มีข้อมูล',
                    ),
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
                    Text(
                      'การแพ้ยา : ' + 'ไม่มีข้อมูล',
                    ),
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
