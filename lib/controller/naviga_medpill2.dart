import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Navigation/naviga_medpill.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/page/record.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'dart:ui' as ui;

class PillData extends StatefulWidget {
  final String doctor;

  const PillData({Key? key, required this.doctor}) : super(key: key);

  @override
  _PillDataState createState() => _PillDataState();
}

class _PillDataState extends State<PillData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.blueAccent,
        title: Text('ข้อมูลยาในระบบ'),
        leading: IconButton(
            splashRadius: 20,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.indigo,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SafeArea(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('medpill')
            .orderBy('uid')
            .startAt([widget.doctor]).endAt([widget.doctor]).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];

                return Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Container(
                        child: Image.network(
                          document['image'],
                        ),
                        decoration: BoxDecoration(shape: BoxShape.rectangle),
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
                        alignment: Alignment.centerLeft,
                        child: (Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              document['nameE'],
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                              ),
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
                                      Icons.medication,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(document['descrip']
                                    //  + user.email,
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
                                    color: Colors.green,
                                    child: Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  document['size'],
                                ),
                                // getHN()
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),

                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        padding: EdgeInsets.only(left: 20),
                        height: MediaQuery.of(context).size.height / 20,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueGrey[50],
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    height: 27,
                                    width: 27,
                                    color: Colors.orangeAccent,
                                    child: Icon(
                                      Icons.description,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                                Text(
                                  '   ผลข้างเคียง',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        padding: EdgeInsets.only(left: 20),
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueGrey[50],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    document['SE'],
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w200),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 10,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),

                      // ข้อควรเหลือง 5
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        padding: EdgeInsets.only(left: 20),
                        height: MediaQuery.of(context).size.height / 20,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueGrey[50],
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    height: 27,
                                    width: 27,
                                    color: Colors.yellow,
                                    child: Icon(
                                      Icons.report_problem,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                                Text(
                                  '   ข้อควรระวัง',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        padding: EdgeInsets.only(left: 20),
                        // height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueGrey[50],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    document['cautions'],
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w200),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 10,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),

                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        padding: EdgeInsets.only(left: 20),
                        height: MediaQuery.of(context).size.height / 20,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueGrey[50],
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    height: 27,
                                    width: 27,
                                    color: Colors.red,
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                                Text(
                                  '   ข้อห้ามใช้',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        padding: EdgeInsets.only(left: 20),
                        // height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueGrey[50],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    document['prohibition'],
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w200),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                );
              });
        },
      )),
    );
  }
}
