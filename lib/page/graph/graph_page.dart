import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = true;

  final List<SalesData> chartData1 = [];
  final List<SalesData> chartData2 = [];
  final List<SalesData> chartData3 = [];

  @override
  void initState() {
    super.initState();
    onLoadUser();
  }

  void onLoadUser() {
    auth.authStateChanges().listen((event) async {
      await FirebaseFirestore.instance
          .collection("edit_pressure")
          .doc(event?.email)
          .collection('all')
          .orderBy('Adata_time', descending: true)
          .limit(8)
          .get()
          .then((value) {
        // DateFormat.MMMMd('th').format(DateTime.parse(item.checkDate ?? DateTime.now().toString()).toLocal())
        for (QueryDocumentSnapshot item in value.docs) {
          // print(
          //     "${DateTime.fromMillisecondsSinceEpoch(item.data()['Adata_time'].millisecondsSinceEpoch).toString().split(':')[0]}:${DateTime.fromMillisecondsSinceEpoch(item.data()['Adata_time'].millisecondsSinceEpoch).toString().split(':')[1]}");
          chartData1.add(SalesData(
              "${DateTime.fromMillisecondsSinceEpoch(item.data()['Adata_time'].millisecondsSinceEpoch).toString().split(':')[0]}:${DateTime.fromMillisecondsSinceEpoch(item.data()['Adata_time'].millisecondsSinceEpoch).toString().split(':')[1]}",
              double.parse(item.data()['data_title'])));
          chartData2.add(SalesData(
              "${DateTime.fromMillisecondsSinceEpoch(item.data()['Adata_time'].millisecondsSinceEpoch).toString().split(':')[0]}:${DateTime.fromMillisecondsSinceEpoch(item.data()['Adata_time'].millisecondsSinceEpoch).toString().split(':')[1]}",
              double.parse(item.data()['data_description'])));
          chartData3.add(SalesData(
              "${DateTime.fromMillisecondsSinceEpoch(item.data()['Adata_time'].millisecondsSinceEpoch).toString().split(':')[0]}:${DateTime.fromMillisecondsSinceEpoch(item.data()['Adata_time'].millisecondsSinceEpoch).toString().split(':')[1]}",
              double.parse(item.data()['data_heartrate'])));
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
        title: Text("ความดันโลหิตของฉัน"),
      ),
      body: loading
          ? Center(child: CupertinoActivityIndicator(radius: 10))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SfCartesianChart(
                    plotAreaBorderWidth: 0,
                    margin: EdgeInsets.zero,
                    enableAxisAnimation: true,
                    primaryXAxis: CategoryAxis(
                      plotOffset: 10,
                      interval: 1,
                      isVisible: true,
                      labelRotation: 90,
                    ),
                    legend: Legend(
                        isVisible: true,
                        position: LegendPosition.top,
                        overflowMode: LegendItemOverflowMode.wrap),
                    tooltipBehavior: TooltipBehavior(
                      enable: true,
                      duration: 1,
                    ),
                    series: <ChartSeries>[
                      LineSeries<SalesData, String>(
                        markerSettings: MarkerSettings(isVisible: true),
                        enableTooltip: true,
                        dataSource: chartData1,
                        name: 'ความดันโลหิตด้านบน (SYS)',
                        xValueMapper: (SalesData sales, _) => sales.date,
                        yValueMapper: (SalesData sales, _) => sales.value,
                      ),
                      LineSeries<SalesData, String>(
                        markerSettings: MarkerSettings(isVisible: true),
                        enableTooltip: true,
                        dataSource: chartData2,
                        name: 'ความดันโลหิตด้านล่าง (DIA)',
                        xValueMapper: (SalesData sales, _) => sales.date,
                        yValueMapper: (SalesData sales, _) => sales.value,
                      ),
                      LineSeries<SalesData, String>(
                        markerSettings: MarkerSettings(isVisible: true),
                        enableTooltip: true,
                        dataSource: chartData3,
                        name: 'อัตราการเต้นของหัวใจ (PUL)',
                        xValueMapper: (SalesData sales, _) => sales.date,
                        yValueMapper: (SalesData sales, _) => sales.value,
                      ),
                    ]),
              ),
            ),
    );
  }
}

class SalesData {
  SalesData(this.date, this.value);
  final String date;
  final double value;
}
