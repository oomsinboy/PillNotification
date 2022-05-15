import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifiedPage extends StatefulWidget {
  final String? label;
  const NotifiedPage({Key? key, required this.label}) : super(key: key);

  @override
  _NotifiedPageState createState() => _NotifiedPageState();
}

class _NotifiedPageState extends State<NotifiedPage> {
  bool loading = true;
  String dataId = '';

  String name = '';
  String quantity = '';
  String note = '';
  String time = '';

  void loadData() {
    FirebaseFirestore.instance
        .collection('drugs')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('drug')
        .doc(dataId)
        .get()
        .then((value) {
      name = value.data()?['drug_name'];
      quantity = value.data()?['drug_quantity'] ?? 0;
      note = value.data()?['drug_note'];
      time = value.data()?['drug_time_start'];

      // FirebaseFirestore.instance
      //     .collection('drugs')
      //     .doc(FirebaseAuth.instance.currentUser?.email)
      //     .collection('history')
      //     .where('history_drug_id', isEqualTo: dataId)
      //     .get()
      //     .then((value) {
      //   if (value.size == 0) {
      FirebaseFirestore.instance
          .collection('drugs')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .collection('history')
          .doc()
          .set({
        'history_drug_name': name,
        'history_drug_quantity': quantity,
        'history_drug_id': dataId,
        'history_date': DateTime.now(),
      });
      //   }
      // });

      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      Object? itemId = ModalRoute.of(context)?.settings.arguments;
      dataId = itemId.toString();
      print(dataId);
      if (itemId != null) {
        loadData();
      } else {
        loading = false;
      }
    }

    return loading
        ? Center(child: CupertinoActivityIndicator(radius: 10))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF3a73b5),
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_ios),
                color: Get.isDarkMode ? Colors.white : Colors.white,
              ),
              title: Text('บันทึกยา $name'),
              // style :TextStyle(color: Colors.black)
            ),
            body: Center(
                child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image(
                        image: AssetImage('assets/image/icon_success.png'),
                        height: 150),
                  ),
                  SizedBox(height: 40),
                  Center(),
                  Text(
                    'ชื่อยา: $name',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    'จำนวน: $quantity เม็ด/ครั้ง',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    'เวลาที่แจ้ง: $time',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    'รายละเอียด: $note',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: Text(
                      "บันทึกประวัติการทานยาของคุณเรียบร้อยแล้ว",
                      style: TextStyle(fontSize: 18, color: Colors.green),
                    ),
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            textStyle: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                        child: const Text('ตกลง'),
                      ),
                    ),
                  ),
                ],
              ),
            )),
          );
  }
}
