// import 'package:flutter/cupertino.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Navigation/naviga_medpill2.dart';
// import 'package:flutter_application_1/home.dart';
// import 'package:flutter_application_1/page/record.dart';
// //import 'package:typicons_flutter/typicons_flutter.dart';
// import 'dart:ui' as ui;

// class Medpill extends StatefulWidget {
//   final String type;
//   const Medpill({Key? key, required this.type}) : super(key: key);

//   @override
//   _MedpillState createState() => _MedpillState();
// }

// class _MedpillState extends State<Medpill> {
//   final double _borderRadius = 24;

//   var items = [
//     PlaceInfo(Color(0xff6DC8F3), Color(0xff73A1F9)),
//     PlaceInfo(Color(0xffFFB157), Color(0xffFFA057)),
//     PlaceInfo(Color(0xffFF5B95), Color(0xffF8556D)),
//     PlaceInfo(Color(0xffD76EF5), Color(0xff8F7AFE)),
//     PlaceInfo(Color(0xff42E695), Color(0xff3BB2B8)),
//     PlaceInfo(Color(0xff6DC8F3), Color(0xff73A1F9)),
//     PlaceInfo(Color(0xffFFB157), Color(0xffFFA057)),
//     PlaceInfo(Color(0xffFF5B95), Color(0xffF8556D)),
//     PlaceInfo(Color(0xffD76EF5), Color(0xff8F7AFE)),
//     PlaceInfo(Color(0xff42E695), Color(0xff3BB2B8)),
//     PlaceInfo(Color(0xff6DC8F3), Color(0xff73A1F9)),
//     PlaceInfo(Color(0xffFFB157), Color(0xffFFA057)),
//     PlaceInfo(Color(0xffFF5B95), Color(0xffF8556D)),
//     PlaceInfo(Color(0xffD76EF5), Color(0xff8F7AFE)),
//     PlaceInfo(Color(0xff42E695), Color(0xff3BB2B8)),
//     PlaceInfo(Color(0xff6DC8F3), Color(0xff73A1F9)),
//     PlaceInfo(Color(0xffFFB157), Color(0xffFFA057)),
//     PlaceInfo(Color(0xffFF5B95), Color(0xffF8556D)),
//     PlaceInfo(Color(0xffD76EF5), Color(0xff8F7AFE)),
//     PlaceInfo(Color(0xff42E695), Color(0xff3BB2B8)),
//     PlaceInfo(Color(0xff6DC8F3), Color(0xff73A1F9)),
//     PlaceInfo(Color(0xffFFB157), Color(0xffFFA057)),
//     PlaceInfo(Color(0xffFF5B95), Color(0xffF8556D)),
//     PlaceInfo(Color(0xffD76EF5), Color(0xff8F7AFE)),
//     PlaceInfo(Color(0xff42E695), Color(0xff3BB2B8)),
//     PlaceInfo(Color(0xff6DC8F3), Color(0xff73A1F9)),
//     PlaceInfo(Color(0xffFFB157), Color(0xffFFA057)),
//     PlaceInfo(Color(0xffFF5B95), Color(0xffF8556D)),
//     PlaceInfo(Color(0xffD76EF5), Color(0xff8F7AFE)),
//     PlaceInfo(Color(0xff42E695), Color(0xff3BB2B8)),
//     PlaceInfo(Color(0xff6DC8F3), Color(0xff73A1F9)),
//     PlaceInfo(Color(0xffFFB157), Color(0xffFFA057)),
//     PlaceInfo(Color(0xffFF5B95), Color(0xffF8556D)),
//     PlaceInfo(Color(0xffD76EF5), Color(0xff8F7AFE)),
//     PlaceInfo(Color(0xff42E695), Color(0xff3BB2B8)),
//   ];

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
//       body: Padding(
//         padding: EdgeInsets.only(top: 10),
//         child: StreamBuilder(
//           stream: FirebaseFirestore.instance.collection('medpill').snapshots(),
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (!snapshot.hasData) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             return ListView.builder(
//               scrollDirection: Axis.vertical,
//               physics: ClampingScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: snapshot.data!.size,
//               itemBuilder: (context, index) {
//                 DocumentSnapshot doctor = snapshot.data!.docs[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Stack(
//                     children: [
//                       Container(
//                         height: 150,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(_borderRadius),
//                           gradient: LinearGradient(
//                               colors: [
//                                 items[index].startColor,
//                                 items[index].endColor
//                               ],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight),
//                           boxShadow: [
//                             BoxShadow(
//                               color: items[index].endColor,
//                               blurRadius: 5,
//                               offset: Offset(-2, 3),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Positioned(
//                         right: 0,
//                         bottom: 0,
//                         top: 0,
//                         child: CustomPaint(
//                           size: Size(100, 150),
//                           painter: CustomCardShapePainter(_borderRadius,
//                               items[index].startColor, items[index].endColor),
//                         ),
//                       ),
//                       Container(
//                         child: TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => PillData(),
//                               ),
//                             );
//                           },
//                           child: Positioned.fill(
//                             child: Row(
//                               children: <Widget>[
//                                 Expanded(
//                                   child: Icon(
//                                     Icons.medication_rounded,
//                                     color: Colors.white,
//                                     // size: 15,
//                                   ),
//                                   flex: 2,
//                                 ),
//                                 Expanded(
//                                   flex: 4,
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: <Widget>[
//                                       Text(
//                                         doctor['nameE'],
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 20,
//                                             fontFamily: 'Avenir',
//                                             fontWeight: FontWeight.w700),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.all(2),
//                                       ),
//                                       Text(
//                                         ('/ TAB ' + doctor['tablet'] + doctor['unit']),
//                                         style: TextStyle(
//                                             color: Colors.white60,
//                                             fontSize: 14,
//                                             fontFamily: 'Avenir',
//                                             fontWeight: FontWeight.w700),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.all(4),
//                                       ),
//                                       Text(
//                                         doctor['nameT'],
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 14,
//                                           fontFamily: 'Avenir',
//                                         ),
//                                       ),
//                                       SizedBox(height: 16),
//                                       Row(
//                                         children: <Widget>[
//                                           Icon(
//                                             Icons.circle,
//                                             color: Colors.white,
//                                             size: 2,
//                                           ),
//                                           SizedBox(
//                                             width: 4,
//                                           ),
//                                           Flexible(
//                                             child: Text(
//                                               doctor['descrip'],
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontFamily: 'Avenir',
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Image.network(
//                                     doctor['image'],
//                                   ),
//                                   flex: 2,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       )
//                     ],

//                     // color: Colors.blue[50],
//                     // elevation: 0,
//                     // shape: RoundedRectangleBorder(
//                     //   borderRadius: BorderRadius.circular(10),
//                     // ),
//                     // child: Container(
//                     //   padding: EdgeInsets.only(left: 10, right: 10),
//                     //   width: MediaQuery.of(context).size.width,
//                     //   height: MediaQuery.of(context).size.height / 9,
//                     //   child: TextButton(
//                     //     onPressed: () {
//                     //       Navigator.push(
//                     //         context,
//                     //         MaterialPageRoute(
//                     //           builder: (context) => Record(),
//                     //         ),
//                     //       );
//                     //     },
//                     //     child: Row(
//                     //       crossAxisAlignment: CrossAxisAlignment.center,
//                     //       //mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     //       children: [
//                     //         CircleAvatar(
//                     //           backgroundImage: NetworkImage(doctor['image']),
//                     //           //backgroundColor: Colors.blue,
//                     //           radius: 25,
//                     //         ),
//                     //         SizedBox(
//                     //           width: 20,
//                     //         ),
//                     //         Column(
//                     //           crossAxisAlignment: CrossAxisAlignment.start,
//                     //           mainAxisAlignment: MainAxisAlignment.center,
//                     //           children: [
//                     //             Text(
//                     //               doctor['nameT'],
//                     //             ),
//                     //             Text(
//                     //               doctor['nameE'],
//                     //             ),
//                     //             Text(
//                     //               doctor['descrip'],
//                     //             )
//                     //           ],
//                     //         ),
//                     //         SizedBox(
//                     //           width: 10,
//                     //         ),
//                     //         Expanded(
//                     //           child: Container(
//                     //             alignment: Alignment.centerRight,
//                     //             child: Row(
//                     //               crossAxisAlignment: CrossAxisAlignment.end,
//                     //               mainAxisAlignment: MainAxisAlignment.end,
//                     //               children: [
//                     //                 Icon(
//                     //                   Typicons.star_full_outline,
//                     //                   size: 20,
//                     //                   color: Colors.indigo[400],
//                     //                 ),
//                     //                 SizedBox(
//                     //                   width: 3,
//                     //                 ),
//                     //                 Text(
//                     //                   doctor['tablet'].toString(),
//                     //                 ),
//                     //               ],
//                     //             ),
//                     //           ),
//                     //         ),
//                     //       ],
//                     //     ),
//                     //   ),
//                     // ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class PlaceInfo {
//   final Color startColor;
//   final Color endColor;

//   PlaceInfo(this.startColor, this.endColor);
// }

// class CustomCardShapePainter extends CustomPainter {
//   final double radius;
//   final Color startColor;
//   final Color endColor;

//   CustomCardShapePainter(this.radius, this.startColor, this.endColor);

//   @override
//   void paint(Canvas canvas, Size size) {
//     var radius = 24.0;

//     var paint = Paint();
//     paint.shader = ui.Gradient.linear(
//         Offset(0, 0), Offset(size.width, size.height), [
//       HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
//       endColor
//     ]);

//     var path = Path()
//       ..moveTo(0, size.height)
//       ..lineTo(size.width - radius, size.height)
//       ..quadraticBezierTo(
//           size.width, size.height, size.width, size.height - radius)
//       ..lineTo(size.width, radius)
//       ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
//       ..lineTo(size.width - 1.5 * radius, 0)
//       ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
//       ..close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
