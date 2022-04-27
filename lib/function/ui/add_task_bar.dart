import 'dart:developer';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/task_controller.dart';
import 'package:flutter_application_1/function/button.dart';
import 'package:flutter_application_1/function/ui/input_field.dart';
import 'package:flutter_application_1/function/ui/theme.dart';
import 'package:flutter_application_1/controller/task.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/notifications.service.dart';

class AddTaskPage extends StatefulWidget {
  static const routeName = '/AddTaskPage';
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String? users;
  final _formKey = GlobalKey<FormState>();
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  DateTime _selecteDate = DateTime.now();
  String _endTime = '9:00 PM';
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];

  String _selectedRepeat = 'ไม่มี';
  List<String> repeatList = ['ไม่มี', 'ทุกวัน', 'ทุกสัปดาห์', 'ทุกเดือน'];

  int _selectedColor = 0;
  bool loading = true;
  String editId = '';
  int notiId = 0;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore store = FirebaseFirestore.instance;

  void onLoadEdit() {
    store
        .collection("drugs")
        .doc(auth.currentUser?.email)
        .collection("drug")
        .doc(editId)
        .get()
        .then((value) {
      _titleController.text = value.data()?['drug_name'];
      _quantityController.text = value.data()?['drug_quantity'] ?? 0;
      _noteController.text = value.data()?['drug_note'];
      _selecteDate = DateTime.parse(value.data()?['drug_date']);
      _startTime = value.data()?['drug_time_start'];
      notiId = value.data()?['drug_notification_id'];
      // _selectedRepeat = value.data()?['drug_time_repeat'];
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      Object? itemId = ModalRoute.of(context)?.settings.arguments;
      editId = itemId.toString();
      if (itemId != null) {
        onLoadEdit();
      } else {
        loading = false;
      }
    }
    return Scaffold(
      appBar: _appBar(context),
      body: loading
          ? Center(child: CupertinoActivityIndicator(radius: 10))
          : Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: SingleChildScrollView(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      editId == 'null' ? "เพิ่มยาที่นี่" : 'แก้ไขยาที่นี่',
                      style: HeadingStyle,
                    ),
                    MyInputField(
                      title: 'ชื่อยา',
                      hint: 'กรุณากรอกชื่อยา',
                      controller: _titleController,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'จำนวน (เม็ด/ครั้ง)',
                            style: titleStyle,
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.only(top: 8.0),
                            padding: EdgeInsets.only(left: 14),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              children: [
                                Expanded(
                                    child: TextFormField(
                                  autofocus: false,
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  cursorColor: Get.isDarkMode
                                      ? Colors.grey[100]
                                      : Colors.grey[700],
                                  controller: _quantityController,
                                  style: subtitleStyle,
                                  decoration: InputDecoration(
                                    hintText: 'กรุณากรอกจำนวน',
                                    hintStyle: subtitleStyle,
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                context.theme.backgroundColor,
                                            width: 0)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                context.theme.backgroundColor,
                                            width: 0)),
                                  ),
                                ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    MyInputField(
                      title: 'หมายเหตุ',
                      hint: 'กรุณาใส่ช่วงที่กินยา',
                      controller: _noteController,
                    ),
                    MyInputField(
                      title: 'วันที่',
                      hint:
                          '${_selecteDate.day}/${_selecteDate.month}/${_selecteDate.year}',
                      widget: IconButton(
                        icon: Icon(Icons.calendar_today_outlined),
                        color: Colors.grey,
                        onPressed: () {
                          print('เลือกวันที่');
                          _getDateFromUser();
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyInputField(
                            title: 'เวลา',
                            hint: _startTime,
                            widget: IconButton(
                              onPressed: () {
                                _getTimeFromUser(isStartTime: true);
                              },
                              icon: Icon(
                                Icons.access_time_rounded,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 12,
                        // ),
                        // Expanded(
                        //   child: MyInputField(
                        //     title: 'หมดเวลา',
                        //     hint: _endTime,
                        //     widget: IconButton(
                        //       onPressed: () {
                        //         _getTimeFromUser(isStartTime: false);
                        //       },
                        //       icon: Icon(
                        //         Icons.access_time_rounded,
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    // MyInputField(
                    //   title: 'เวลาเตือน',
                    //   hint: '$_selectedRemind นาที',
                    //   widget: DropdownButton(
                    //     icon: Icon(
                    //       Icons.keyboard_arrow_down,
                    //       color: Colors.grey,
                    //     ),
                    //     iconSize: 32,
                    //     elevation: 4,
                    //     style: subtitleStyle,
                    //     underline: Container(
                    //       height: 0,
                    //     ),
                    //     onChanged: (String? newValue) {
                    //       setState(() {
                    //         _selectedRemind = int.parse(newValue!);
                    //       });
                    //     },
                    //     items: remindList.map<DropdownMenuItem<String>>((int value) {
                    //       return DropdownMenuItem<String>(
                    //         value: value.toString(),
                    //         child: Text(value.toString()),
                    //       );
                    //     }).toList(),
                    //   ),
                    // ),
                    // MyInputField(
                    //   title: 'ความถี่',
                    //   hint: '$_selectedRepeat',
                    //   widget: DropdownButton(
                    //     icon: Icon(
                    //       Icons.keyboard_arrow_down,
                    //       color: Colors.grey,
                    //     ),
                    //     iconSize: 32,
                    //     elevation: 4,
                    //     style: subtitleStyle,
                    //     underline: Container(
                    //       height: 0,
                    //     ),
                    //     onChanged: (String? newValue) {
                    //       setState(() {
                    //         _selectedRepeat = newValue!;
                    //       });
                    //     },
                    //     items: repeatList
                    //         .map<DropdownMenuItem<String>>((String? value) {
                    //       return DropdownMenuItem<String>(
                    //         value: value,
                    //         child: Text(value!,
                    //             style: TextStyle(color: Colors.grey)),
                    //       );
                    //     }).toList(),
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // _colorPallete(),
                        MyButton(
                          label: editId == 'null' ? 'เพิ่มยา' : 'แก้ไขยา',
                          onTap: () => _validateDate(),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  _validateDate() async {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();
      // Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        "กรุณากรอก",
        "กรุณากรอกทุกช่อง !",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: pinkClr,
        icon: Icon(Icons.warning_amber_rounded),
      );
    }
  }

  _addTaskToDb() async {
    // int value = await _taskController.addTask(
    //     task: Task(
    //   note: _noteController.text,
    //   title: _titleController.text,
    //   date: DateFormat.yMd().format(_selecteDate),
    //   startTime: _startTime,
    //   endTime: _endTime,
    //   remind: _selectedRemind,
    //   repeat: _selectedRepeat,
    //   color: _selectedColor,
    //   isCompleted: 0,
    // ));
    // print('My id is' + "$value");
    String datetime = DateFormat('yyyy-MM-dd').format(_selecteDate);
    if (editId == 'null') {
      notiId = new Random().nextInt(99999999);
      store
          .collection("drugs")
          .doc(auth.currentUser?.email)
          .collection("drug")
          .add({
        'drug_name': _titleController.text,
        'drug_quantity': _quantityController.text,
        'drug_note': _noteController.text,
        'drug_date': datetime,
        'drug_time_start': _startTime,
        'drug_notification_id': notiId
        // 'drug_time_end': _endTime,
        // 'drug_time_remind': _selectedRemind,
        // 'drug_time_repeat': _selectedRepeat,
      }).then((value) {
        NotificationsService().sendNotification(
            notiId,
            'ยา: ${_titleController.text}\nจำนวน: ${_quantityController.text} เม็ด/ครั้ง\nรายละเอียด: ${_noteController.text}',
            '$datetime $_startTime',
            value.id);
        Navigator.of(context).pop();
      });
    } else {
      store
          .collection("drugs")
          .doc(auth.currentUser?.email)
          .collection("drug")
          .doc(editId)
          .update({
        'drug_name': _titleController.text,
        'drug_quantity': _quantityController.text,
        'drug_note': _noteController.text,
        'drug_date': datetime,
        'drug_time_start': _startTime,
        // 'drug_time_end': _endTime,
        // 'drug_time_remind': _selectedRemind,
        // 'drug_time_repeat': _selectedRepeat,
      }).then((value) async {
        NotificationsService().cancelNotification(notiId);
        await NotificationsService().sendNotification(
            notiId,
            'ยา: ${_titleController.text}\nจำนวน: ${_quantityController.text} เม็ด/ครั้ง\nรายละเอียด: ${_noteController.text}',
            '$datetime $_startTime',
            editId);
        Navigator.of(context).pop();
      });
    }
  }

  _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " เลือกสี",
          style: titleStyle,
        ),
        SizedBox(
          height: 6,
        ),
        Wrap(
          children: List<Widget>.generate(3, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                  print("$index");
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                          ? pinkClr
                          : yellowClr,
                  child: _selectedColor == index
                      ? Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 16,
                        )
                      : Container(),
                ),
              ),
            );
          }),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      //backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
    );

    if (_pickerDate != null) {
      setState(() {
        _selecteDate = _pickerDate;
        print(_selecteDate);
      });
    } else {
      print('ค่าว่างหรือมีบางอย่างผิดพลาด');
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var _pickedTime = await _showTimePicker();
    print(_pickedTime.format(context));
    String _formatedTime = _pickedTime.format(context);
    print(_formatedTime);
    if (_pickedTime == null)
      print("time canceld");
    else if (isStartTime)
      setState(() {
        _startTime = _formatedTime;
      });
    else if (!isStartTime) {
      setState(() {
        _endTime = _formatedTime;
      });
      //_compareTime();
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(
          _startTime.split(":")[1].split(" ")[0],
        ),
      ),
    );
  }
}
