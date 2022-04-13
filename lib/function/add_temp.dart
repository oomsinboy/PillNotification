import 'package:flutter/material.dart';

class AddTemp extends StatefulWidget {
  @override
  _AddTempState createState() => _AddTempState();
}

class _AddTempState extends State<AddTemp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3a73b5),
        title: Text('ประวัติอัตตราชีพจร'),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, int index) {
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 9, horizontal: 6),
            child: ListTile(
              title: Text("ความดันโลหิตด้านบน : \n\nความดันโลหิตด้านล่าง : "),
              subtitle: Text("\nวันที่ : 10/11/2021"),
              leading: CircleAvatar(
                radius: 30,
                child: FittedBox(
                  child: Text("158"),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
