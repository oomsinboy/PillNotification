import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class DataHistoryList extends StatefulWidget {
  @override
  _DataHistoryListState createState() => _DataHistoryListState();
}

// ignore: camel_case_types
class _DataHistoryListState extends State<DataHistoryList> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  late String _documentID;
  late String message;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  Future<void> deleteAppointment(String docID) {
    return FirebaseFirestore.instance
        .collection('edit_pressure')
        .doc(user.email)
        .collection('all')
        .doc()
        .delete();
  }

  String _dateFormatter(String _timestamp) {
    String formattedDate =
        DateFormat('dd-MM-yyyy').format(DateTime.parse(_timestamp));
    return formattedDate;
  }

  String _timeFormatter(String _timestamp) {
    String formattedTime =
        DateFormat('kk:mm').format(DateTime.parse(_timestamp));
    return formattedTime;
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "ยกเลิก",
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "ลบ",
        style: TextStyle(fontFamily: 'FC Minimal', fontSize: 20),
      ),
      onPressed: () {
        deleteAppointment(_documentID);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "ยืนยันการลบ",
        style: TextStyle(fontFamily: 'FC Minimal', fontSize: 25),
      ),
      content: Stack(
        alignment: Alignment.topLeft,
        children: [
          /*Image.asset(
            'assets/images/check.png',
            height: 30,
            width: 30,
          ),*/
          Text(
            "             ข้อมูลจะถูกลบทั้งหมด",
            style: TextStyle(fontFamily: 'FC Minimal', fontSize: 20),
          )
        ],
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  _checkDiff(DateTime _date) {
    var diff = DateTime.now().difference(_date).inHours;
    if (diff > 2) {
      return true;
    } else {
      return false;
    }
  }

  _compareDate(String _date) {
    if (_dateFormatter(DateTime.now().toString())
            .compareTo(_dateFormatter(_date)) ==
        0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('โชว์ข้อมูลความดัน');
    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('edit_pressure')
            .doc(user.email)
            .collection('all')
            // .orderBy('date')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return snapshot.data!.size == 0
              ? Center(
                  child: Text(
                    'ว่าง',
                    style: TextStyle(
                      fontFamily: 'FC Minimal',
                      color: Colors.grey[600],
                      fontSize: 28,
                    ),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    print(_compareDate(
                        document['Adata_time'].toDate().toString()));
                    if (_checkDiff(document['Adata_time'].toDate())) {
                      deleteAppointment(document.id);
                    }

                    return Card(
                      elevation: 2,
                      child: InkWell(
                        onTap: () {},
                        child: ExpansionTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  'วันที่ : ' + 
                                      _dateFormatter(document['Adata_time']
                                          .toDate()
                                          .toString()) +
                                      "   เวลา : " +
                                      _timeFormatter(document['Adata_time']
                                          .toDate()
                                          .toString()),
                                  style: TextStyle(
                                      fontFamily: 'FC Minimal',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 0,
                              ),
                            ],
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15, right: 10, left: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'ความดันโลหิตด้านบน : ' +
                                            (document['data_title']),
                                        /*'' + 
                                            (document['data_title']                                       
                                          .toString()) +
                                        "/" +
                                            (document['data_description']
                                          .toString()),*/
                                        style: TextStyle(
                                            fontSize: 14),
                                      ),
                                      Text(
                                        'ความดันโลหิตด้านล่าง : ' +
                                            (document['data_description']),
                                        style: TextStyle(                                           
                                            fontSize: 14),
                                      ),
                                      Text(
                                        'อัตราการเต้นของหัวใจ : ' + (document['data_heartrate']),
                                        style: TextStyle(
                                            fontSize: 14),
                                      ),

                                    ],
                                  ),
                                  IconButton(
                                    tooltip: 'Delete list',
                                    icon: Icon(
                                      Icons.delete_sweep_sharp,
                                      color: Colors.black87,
                                    ),
                                    onPressed: () {
                                      print("ลบข้อมูล " + document.id);
                                      _documentID = document.id;
                                      showAlertDialog(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
