import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Navigation/navigation_drawer.dart';
import 'package:flutter_application_1/controller/task_controller.dart';
import 'package:flutter_application_1/function/ui/add_task_bar.dart';
import 'package:flutter_application_1/function/button.dart';
import 'package:flutter_application_1/controller/task_tile.dart';
import 'package:flutter_application_1/function/ui/theme.dart';
import 'package:flutter_application_1/function/ui/theme_service.dart';
import 'package:flutter_application_1/controller/task.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../controller/notifi_page.dart';
import '../../controller/notifications.service.dart';

class AddDrug extends StatefulWidget {
  const AddDrug({Key? key}) : super(key: key);

  @override
  _AddDrugState createState() => _AddDrugState();
}

class _AddDrugState extends State<AddDrug> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  var notifyHelper;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('buil method called');
    return Scaffold(
      drawer: DrawerTest(),
      appBar: _appBar(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          SizedBox(
            height: 10,
          ),
          _showTasks(),
        ],
      ),
    );
  }

  Widget _showTasks() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('drugs')
            .doc(FirebaseAuth.instance.currentUser?.email)
            .collection('drug')
            .where('drug_date',
                isEqualTo: DateFormat('yyyy-MM-dd').format(_selectedDate))
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return snapshot.data!.size == 0
              ? Center(
                  child: Text(
                    'ว่าง',
                    style: TextStyle(
                      fontFamily: 'FC Minimal',
                      color: Colors.grey[600],
                      fontSize: 28,
                    ),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                            child: FadeInAnimation(
                                child: GestureDetector(
                          onTap: () {
                            // NotificationsService().sendNotificationNow(
                            //     document.data()?['drug_notification_id'],
                            //     'ยา: ${document.data()?['drug_name']} \nรายละเอียด:${document.data()?['drug_note']}',
                            //     document.id);
                            selectMenu(document.id,
                                document.data()?['drug_notification_id']);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Card(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'ชื่อยา: ${document.data()?['drug_name']}'),
                                    Text(
                                        'จำนวน: ${document.data()?['drug_quantity'] ?? 0} เม็ด/ครั้ง'),
                                    Text(
                                        'หมายเหตุ: ${document.data()?['drug_note']}'),
                                    Text(
                                        'เวลาเตือน: ${document.data()?['drug_time_start']}'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))));
                  });
        });
  }

  Future<void> selectMenu(String id, int notiId) async {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // ListTile(
            //   leading: const Icon(Icons.alarm),
            //   title: const Text('test notification'),
            //   onTap: () {
            //     NotificationsService().sendNotificationNow(
            //         notiId, 'ยา: $id \nรายละเอียด:$id', id);
            //     Navigator.pop(context);
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.medication_liquid),
              title: const Text('บันทึกการทานยา'),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => NotifiedPage(label: id), arguments: id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('แก้ไข'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .pushNamed(AddTaskPage.routeName, arguments: id)
                    .whenComplete(() => setState(() => null));
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('ลบ'),
              onTap: () async {
                Navigator.pop(context);
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('ลบการแจ้งเตือน'),
                    content: const Text('ยืนยันการลบการแจ้งเตือนนี้หรือไม่?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('ยกเลิก'),
                      ),
                      TextButton(
                        onPressed: () {
                          NotificationsService().cancelNotification(notiId);
                          FirebaseFirestore.instance
                              .collection('drugs')
                              .doc(FirebaseAuth.instance.currentUser?.email)
                              .collection('drug')
                              .doc(id)
                              .delete()
                              .then((value) {
                            Navigator.pop(context);
                            setState(() {});
                          });
                        },
                        child: const Text('ยืนยัน'),
                      ),
                    ],
                  ),
                );

                // await HealthCheckService().delete(checkId).catchError((ex) {
                //   inspect(ex);
                //   Toasts.toastError(context, null, 2);
                // });
                // notification =
                //     await NotificationService().findOneByCheckId(checkId);
                // await NotificationService()
                //     .delete(notification.notiId ?? '')
                //     .catchError((ex) {
                //   inspect(ex);
                //   Toasts.toastError(context, null, 2);
                // });
                // setState(() {
                //   Toasts.toastSuccess(context, Constants.textAlertDelete, 2);
                //   Navigator.pop(context);
                // });
              },
            ),
          ],
        );
      },
    );
  }

  // _showTasks() {
  //   return Expanded(
  //     child: Obx(
  //       () {
  //         return ListView.builder(
  //           itemCount: _taskController.taskList.length,
  //           itemBuilder: (_, index) {
  //             Task task = _taskController.taskList[index];
  //             print(_taskController.taskList.length);
  //             if (task.repeat == 'Daily') {
  //               DateTime date =
  //                   DateFormat.jm().parse(task.startTime.toString());
  //               var myTime = DateFormat('HH:mm').format(date);
  //               notifyHelper.scheduledNotification(
  //                 int.parse(myTime.toString().split(':')[0]),
  //                 int.parse(myTime.toString().split(':')[1]),
  //               );
  //               return AnimationConfiguration.staggeredList(
  //                 position: index,
  //                 child: SlideAnimation(
  //                   child: FadeInAnimation(
  //                     child: Row(
  //                       children: [
  //                         GestureDetector(
  //                           onTap: () {
  //                             _showBottomSheet(context, task);
  //                           },
  //                           child: TaskTile(task),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             }
  //             if (task.date == DateFormat.yMd().format(_selectedDate)) {
  //               return AnimationConfiguration.staggeredList(
  //                 position: index,
  //                 child: SlideAnimation(
  //                   child: FadeInAnimation(
  //                     child: Row(
  //                       children: [
  //                         GestureDetector(
  //                           onTap: () {
  //                             _showBottomSheet(context, task);
  //                           },
  //                           child: TaskTile(task),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             } else {
  //               return Container();
  //             }
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 2),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
        color: Get.isDarkMode ? darkGreyClr : Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
              ),
            ),
            Spacer(),
            task.isCompleted == 1
                ? Container()
                : _bottomSheetButton(
                    label: "สำเร็จแล้ว",
                    onTap: () {
                      _taskController.markTaskCompleted(task.id!);
                      Get.back();
                    },
                    clr: primaryClr,
                    context: context,
                  ),
            _bottomSheetButton(
              label: "ลบข้อมูล",
              onTap: () {
                _taskController.delete(task);

                Get.back();
              },
              clr: Colors.red[300]!,
              context: context,
            ),
            SizedBox(
              height: 20,
            ),
            _bottomSheetButton(
              label: "ออก",
              onTap: () {
                Get.back();
              },
              clr: Colors.red[300]!,
              isClose: true,
              context: context,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose == true
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? titleStyle
                : titleStyle.copyWith(
                    color: Colors.white,
                  ),
          ),
        ),
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: DatePicker(
        DateTime.now(),
        height: 90,
        width: 70,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
            print(DateFormat.yMd().format(_selectedDate));
          });
        },
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  " วันนี้",
                  style: HeadingStyle,
                )
              ],
            ),
          ),
          MyButton(
            label: "+ เพิ่มยา",
            onTap: () async {
              await Get.to(() => AddTaskPage());
              // _taskController.getTasks();
            },
          ),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      actions: [
        GestureDetector(
          onTap: () {
            ThemeService().switchTheme();
            notifyHelper.displayNotification(
              title: "Theme Changed",
              body: Get.isDarkMode
                  ? "Activated Dark Theme"
                  : "Activated Light Theme",
            );
            notifyHelper.scheduledNotification();
          },
          child: Icon(
            Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
            size: 20,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
