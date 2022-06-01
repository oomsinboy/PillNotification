import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PressureAveragePage extends StatefulWidget {
  const PressureAveragePage({Key? key}) : super(key: key);

  @override
  _PressureAveragePageState createState() => _PressureAveragePageState();
}

class _PressureAveragePageState extends State<PressureAveragePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = true;
  List<String> dataDate = [];
  List dataValue = [];

  @override
  void initState() {
    super.initState();
    onLoadData();
  }

  void onLoadData() {
    auth.authStateChanges().listen((event) async {
      await FirebaseFirestore.instance
          .collection("edit_pressure")
          .doc(event?.email)
          .collection('all')
          .orderBy('Adata_time', descending: true)
          .get()
          .then((value) {
        // print(
        //     '${DateFormat.MMMMEEEEd('th').format(DateTime.parse(DateTime.now().toString()))} พ.ศ. ${int.parse(DateFormat.y('th').format(DateTime.parse(DateTime.now().toString()))) + 543}');
        for (QueryDocumentSnapshot item in value.docs) {
          String itemDate =
              '${DateFormat.MMMMEEEEd('th').format(DateTime.parse(DateTime.fromMillisecondsSinceEpoch(item.data()['Adata_time'].millisecondsSinceEpoch).toString()))} พ.ศ. ${int.parse(DateFormat.y('th').format(DateTime.parse(DateTime.fromMillisecondsSinceEpoch(item.data()['Adata_time'].millisecondsSinceEpoch).toString()))) + 543}';
          int itemIndex = dataDate.indexOf(itemDate);
          if (itemIndex == -1) {
            dataDate.add(itemDate);
            dataValue.add([
              [int.parse(item.data()['data_title'])],
              [int.parse(item.data()['data_description'])],
              [int.parse(item.data()['data_heartrate'])]
            ]);
          } else {
            dataValue[itemIndex][0].add(int.parse(item.data()['data_title']));
            dataValue[itemIndex][1]
                .add(int.parse(item.data()['data_description']));
            dataValue[itemIndex][2]
                .add(int.parse(item.data()['data_heartrate']));
          }

          // print(
          //     '${DateFormat.MMMMEEEEd('th').format(DateTime.parse(DateTime.fromMillisecondsSinceEpoch(item.data()['Adata_time'].millisecondsSinceEpoch).toString()))} พ.ศ. ${int.parse(DateFormat.y('th').format(DateTime.parse(DateTime.fromMillisecondsSinceEpoch(item.data()['Adata_time'].millisecondsSinceEpoch).toString()))) + 543}');
          // print(
          //     "${DateTime.fromMillisecondsSinceEpoch(item.data()['Adata_time'].millisecondsSinceEpoch).toString().split(':')[0]}:${DateTime.fromMillisecondsSinceEpoch(item.data()['Adata_time'].millisecondsSinceEpoch).toString().split(':')[1]}");
        }

        setState(() {
          loading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF3a73b5),
        title: Text("ความดันเฉลี่ย"),
      ),
      body: loading
          ? Center(child: CupertinoActivityIndicator(radius: 10))
          : Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: dataDate.length,
                  itemBuilder: (context, index) {
                    int value1 = 0;
                    int value2 = 0;
                    int value3 = 0;
                    dataValue[index][0].forEach((int e) => value1 += e);
                    dataValue[index][1].forEach((int e) => value2 += e);
                    dataValue[index][2].forEach((int e) => value3 += e);
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dataDate[index],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                                'ความดันโลหิตด้านบนเฉลี่ย: ${(value1 / dataValue[index][0].length).toStringAsFixed(0)}'),
                            Text(
                                'ความดันโลหิตด้านล่างเฉลี่ย: ${(value2 / dataValue[index][1].length).toStringAsFixed(0)}'),
                            Text(
                                'อัตราการเต้นของหัวใจเฉลี่ย: ${(value3 / dataValue[index][2].length).toStringAsFixed(0)}'),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}
