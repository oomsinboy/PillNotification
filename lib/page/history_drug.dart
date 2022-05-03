import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Navigation/navigation_drawer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';

class Historydrug extends StatefulWidget {
  @override
  _HistorydrugState createState() => _HistorydrugState();
}

class _HistorydrugState extends State<Historydrug> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerTest(),
      appBar: AppBar(
        backgroundColor: Color(0xFF3a73b5),
        title: Text('ประวัติการทานยา'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: _showTasks(),
      ),
      //backgroundColor: Color(0xFF73AEF5)
    );
  }

  Widget _showTasks() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('drugs')
            .doc(FirebaseAuth.instance.currentUser?.email)
            .collection('history')
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
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                            child: FadeInAnimation(
                                child: GestureDetector(
                          onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              //backgroundColor: Colors.green,
                              title: const Text('ลบประวัติ'),
                              content: Text(
                                  'ยืนยันการลบประวัติยา ${document.data()?['history_drug_name']} ใช่หรือไม่?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('ยกเลิก'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('drugs')
                                        .doc(FirebaseAuth
                                            .instance.currentUser?.email)
                                        .collection('history')
                                        .doc(document.id)
                                        .delete()
                                        .then((value) {
                                      Navigator.pop(context);
                                      setState(() {});
                                    });
                                  },
                                  child: const Text('ยืนยัน'),
                                ),
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 1),
                            child: Card(
                              child: Container(
                                color: Colors.grey[300],
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'ชื่อยา: ${document.data()?['history_drug_name']}'),
                                    Text(
                                        'จำนวน: ${document.data()?['history_drug_quantity'] ?? 0} เม็ด/ครั้ง'),
                                    Text(
                                        'วันที่บันทึก: ${DateFormat('dd-MM-yyyy').format(DateTime.fromMicrosecondsSinceEpoch(document.data()?['history_date'].microsecondsSinceEpoch))}'),
                                    Text(
                                        'เวลาบันทึก: ${DateFormat('H').format(DateTime.fromMicrosecondsSinceEpoch(document.data()?['history_date'].microsecondsSinceEpoch)).length == 1 ? '0' : ''}${DateFormat('H').format(DateTime.fromMicrosecondsSinceEpoch(document.data()?['history_date'].microsecondsSinceEpoch))}:${DateFormat('m').format(DateTime.fromMicrosecondsSinceEpoch(document.data()?['history_date'].microsecondsSinceEpoch)).length == 1 ? '0' : ''}${DateFormat('m').format(DateTime.fromMicrosecondsSinceEpoch(document.data()?['history_date'].microsecondsSinceEpoch))}'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))));
                  });
        });
  }
}
