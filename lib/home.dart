import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/function/ui/add_drug.dart';
import 'package:flutter_application_1/test/screens/dashboard_screen.dart';
import 'page/history_drug.dart';
import 'page/more.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentindex = 0;
  late PageController _pageController;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  Future<void> getUser() async {
    user = auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    getUser();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => currentindex = index);
        },
        children: [
          //Homepage(),
          AddDrug(),
          Historydrug(),
          DashboardScreen(),
          //Record(),
          More(),
        ],
      ),
      bottomNavigationBar: buildBottomNavigation(),
    );
  }

  Widget buildBottomNavigation() {
    final inactiveColor = Colors.grey;

    return BottomNavyBar(
      containerHeight: 60,
      selectedIndex: currentindex,
      onItemSelected: (index) {
        setState(() => currentindex = index);
        _pageController.jumpToPage(index);
      },
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.home),
          title: Text('หน้าหลัก'),
          inactiveColor: inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.description),
          title: Text('ประวัติยา'),
          inactiveColor: inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.insert_chart),
          title: Text('บันทึกค่า'),
          inactiveColor: inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.more_horiz),
          title: Text('อื่นๆ'),
          inactiveColor: inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
