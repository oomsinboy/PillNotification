import 'package:flutter/material.dart';
import 'package:flutter_application_1/Navigation/navigation_drawer.dart';
import 'package:flutter_application_1/function/listdata_pressure.dart';
import 'package:flutter_application_1/page/record.dart';
import 'package:flutter_application_1/test/res/custom_colors.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.firebaseNavy,
      drawer: DrawerTest(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF3a73b5),

        title: Text("บันทึกค่าความดันโลหิต"),
        //title: AppBarTitle(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => /*AddScreen()*/ Record(),
            ),
          );
        },
        backgroundColor: CustomColors.firebaseOrange,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            // bottom: 20.0,
            top: 10,
          ),
          child: DataHistoryList(),
        ),
      ),
    );
  }
}
