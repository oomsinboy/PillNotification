import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Navigation/navigation_drawer.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  bool _notiapp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerTest(),

      appBar: AppBar(
        backgroundColor: Color(0xFF3a73b5),
        title: Text('อื่นๆ'),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Text(
                    'สรุปผล',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.medication_outlined),
                  title: const Text('การใช้ยาของฉัน'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.auto_graph),
                  title: const Text('ความดันโลหิต'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () => Navigator.pushNamed(context, '/graphpage'),
                ),
                ListTile(
                  leading: Icon(Icons.warning_amber),

                  title: const Text('คำแนะนำในการใช้ยา'),
                  //subtitle: Text('เปลี่ยนรหัสผ่านการเข้าใช้งาน'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () => Navigator.pushNamed(context, '/guide pill'),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Text(
                    'ตั้งค่าการใช้งาน',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Divider(),
                SwitchListTile(
                  title: const Text('การแจ้งเตือนในเครื่อง'),
                  value: _notiapp,
                  onChanged: (bool value) {
                    setState(() {
                      _notiapp = value;
                    });
                  },
                  secondary: const Icon(Icons.notifications_active),
                ),
              ],
            ),
          ),
        ],
      ),
      // backgroundColor: Color(0xFF73AEF5)
    );
  }
}
