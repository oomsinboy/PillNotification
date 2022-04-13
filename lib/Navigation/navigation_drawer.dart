import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/page/screen_main/user_page.dart';

class DrawerTest extends StatefulWidget {
  const DrawerTest({Key? key}) : super(key: key);

  @override
  _DrawerTestState createState() => _DrawerTestState();
}

class _DrawerTestState extends State<DrawerTest> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  String? uid;
  String? name;
  String? numberHN;

  @override
  void initState() {
    super.initState();
    findUid();
  }

//หาค่า Uid ของ User ที่ login อยู่
  Future<Null> findUid() async {
    // await Firebase.initializeApp().then((value) async {
    // ignore: await_only_futures
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      setState(() {
        uid = event!.uid;
        name = event.displayName;
        numberHN = event.displayName;
      });
    });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Text(
                  'User',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                  ),
                )),
            accountName: Text(
              'ชื่อ : $name',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            accountEmail: Text(
              'หมายเลข HN : $numberHN',
              style: TextStyle(color: Colors.black, fontSize: 12.0),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: const Text(
              'ข้อมูลผู้ใช้งาน',
              style: TextStyle(fontSize: 20.0),
            ),
            subtitle: Text('ข้อมูลของผู้ใช้'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PageDataUser(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.list_alt),
            title:
                const Text('ข้อมูลยาในระบบ', style: TextStyle(fontSize: 20.0)),
            subtitle: Text('ข้อมูลยาโรคความดันโลหิตสูง'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text('ตั้งค่า', style: TextStyle(fontSize: 20.0)),
            subtitle: Text('ตั้งค่าการใช้งาน'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () => Navigator.pushNamed(context, '/pagemore'),
          ),
          Divider(),
          ListTile(
            title: const Text('ออกจากระบบ', style: TextStyle(fontSize: 20.0)),
            trailing: Icon(Icons.exit_to_app),
            onTap: () async {
              await FirebaseAuth.instance.signOut().then(
                    (value) => Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/authen',
                      (route) => false,
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }
}
