// import 'package:flutter/cupertino.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Navigation/naviga_medpill.dart';
// import 'package:flutter_application_1/home.dart';
// import 'package:flutter_application_1/page/record.dart';
// //import 'package:typicons_flutter/typicons_flutter.dart';
// import 'dart:ui' as ui;

// class PillData extends StatefulWidget {
//   const PillData({Key? key}) : super(key: key);

//   @override
//   _PillDataState createState() => _PillDataState();
// }

// class _PillDataState extends State<PillData> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // backgroundColor: Colors.blueAccent,
//         title: Text('ข้อมูลยาในระบบ'),
//         leading: IconButton(
//             splashRadius: 20,
//             icon: Icon(
//               Icons.arrow_back_ios,
//               color: Colors.indigo,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             }),
//       ),
//       body: SafeArea(
//           child: ListView(
//         children: [
//           SizedBox(height: 15),
//           Container(
//             child: Image.asset(
//               'assets/MANi-M.png',
//             ),
//             decoration: BoxDecoration(shape: BoxShape.rectangle),
//           ),
//           SizedBox(height: 25),
//           Container(
//             margin: EdgeInsets.only(left: 15, right: 15),
//             padding: EdgeInsets.only(left: 20),
//             height: MediaQuery.of(context).size.height / 15,
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.blueGrey[50],
//             ),
//             alignment: Alignment.center,
//             child: (Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Spironolactone TAB 25 MG',
//                   style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
//                 ),
//               ],
//             )),
//           ),
//           SizedBox(height: 25),
//           Container(
//             margin: EdgeInsets.only(left: 15, right: 15),
//             padding: EdgeInsets.only(left: 20),
//             height: MediaQuery.of(context).size.height / 7,
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.blueGrey[50],
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(30),
//                       child: Container(
//                         height: 27,
//                         width: 27,
//                         color: Colors.blueAccent,
//                         child: Icon(
//                           Icons.medication,
//                           color: Colors.white,
//                           size: 18,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text('ยาใช้รักษาภาวะความดันโลหิตสูง/ยาขับปัสสาวะ'
//                         //  + user.email,
//                         ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(30),
//                       child: Container(
//                         height: 27,
//                         width: 27,
//                         color: Colors.green,
//                         child: Icon(
//                           Icons.done,
//                           color: Colors.white,
//                           size: 16,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text(
//                       'รับประทานครั้งละ 1-4  เม็ดวันละ 1 ครั้ง',
//                     ),
//                     // getHN()
//                   ],
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 25),
//           Container(
//             margin: EdgeInsets.only(left: 15, right: 15),
//             padding: EdgeInsets.only(left: 20),
//             height: MediaQuery.of(context).size.height / 3,
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.blueGrey[50],
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(30),
//                       child: Container(
//                         height: 27,
//                         width: 27,
//                         color: Colors.blueAccent,
//                         child: Icon(
//                           Icons.location_on,
//                           color: Colors.white,
//                           size: 16,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text(
//                       'ผลข้างเคียง : ' + 'ไม่มีข้อมูล',
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(30),
//                       child: Container(
//                         height: 27,
//                         width: 27,
//                         color: Colors.yellow,
//                         child: Icon(
//                           Icons.report_problem,
//                           color: Colors.white,
//                           size: 16,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text(
//                       'ข้อควรระวัง' +
//                           '\n'
//                               '-	ควรระวังในผู้ป่วยโรคตับ/หัวใจ' +
//                           '\n' +
//                           'หรือผู้ได้รับการใส่สายสวนหัวใจ' +
//                           '\n' +
//                           '-	ควรระวังการใช้ในผู้ที่มีตับและไตบกพร่อง' +
//                           '\n' +
//                           '-	ควรระวังในหญิงตั้งครรภ์และหญิงให้นมบุตร',
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(30),
//                       child: Container(
//                         height: 27,
//                         width: 27,
//                         color: Colors.red,
//                         child: Icon(
//                           Icons.report_rounded,
//                           color: Colors.white,
//                           size: 16,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text('ข้อห้ามใช้ ' +
//                         '\n'
//                             '-	ห้าม ใช้ในผู้ที่มีประวัติแพ้ยานี้' +
//                         '\n' +
//                         '-	ห้าม ใช้ในผู้ที่มีภาวะปัสสาวะออกน้อยผิดปกติ ' +
//                         '\n' +
//                         '-	ห้าม ใช้ในผู้ที่มีภาวะ  Addison disease'),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 25),
//         ],
//       )),
//     );
//   }
// }
