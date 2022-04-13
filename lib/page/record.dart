import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/test/res/custom_colors.dart';
import 'package:flutter_application_1/test/utils/validator.dart';
import 'package:intl/intl.dart';

class Record extends StatefulWidget {
  const Record({Key? key}) : super(key: key);
  @override
  _RecordState createState() => _RecordState();
}

class _RecordState extends State<Record> {
  late DateTime pickedDate;
  late TimeOfDay time;
  late String dateUTC;
  final _formKey = GlobalKey<FormState>();

  late String users;

  User? user = FirebaseAuth.instance.currentUser;

  bool _isProcessing = false;

  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
  }

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _data1Controller = TextEditingController();
  final TextEditingController _data2Controller = TextEditingController();
  final TextEditingController _data3Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final recordButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          final isValid = _formKey.currentState!.validate();

          if (isValid) {
            _formKey.currentState!.setState(() {
              _createEdit_pressure();
            });
            Navigator.of(context).pop();
          }
        },
        child: Text(
          "บันทึก",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
    print('บันทึกค่าความดัน');
    return Scaffold(
      // drawer: DrawerTest(),
      appBar: AppBar(
        backgroundColor: Color(0xFF3a73b5),
        title: Text('บันทึกค่าความดันโลหิตของคุณ'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(28),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "วันที่ : ${pickedDate.day}/${pickedDate.month}/${pickedDate.year} ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_drop_down),
                    onTap: _pickDate,
                  ),
                  ListTile(
                    title: Text(
                      "เวลา : ${time.hour} : ${time.minute}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_drop_down),
                    onTap: _pickTime,
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.blueAccent,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'ความดันโลหิตด้านบน (SYS)',
                    style: TextStyle(
                      color: CustomColors.firebaseGrey,
                      fontSize: 20.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.numberWithOptions(),
                    controller: _data1Controller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ('กรุณากรอกตัวเลข');
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _data1Controller.text = value!;
                    },
                    decoration: InputDecoration(
                      suffix: Text('mmHg'),
                      //labelText: 'ความดันโลหิตด้านบน',
                      labelStyle: TextStyle(fontSize: 18),
                      border: OutlineInputBorder(),
                      filled: true,
                      //fillColor: Colors.white54
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'ความดันโลหิตด้านล่าง (DIA)',
                    style: TextStyle(
                      color: CustomColors.firebaseGrey,
                      fontSize: 20.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.numberWithOptions(),
                    controller: _data2Controller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("กรุณาใส่หมายเลข HN");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _data2Controller.text = value!;
                    },
                    decoration: InputDecoration(
                      suffix: Text('mmHg'),
                      labelStyle: TextStyle(fontSize: 18),
                      border: OutlineInputBorder(),
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'อัตราการเต้นของหัวใจ (PUL)',
                    style: TextStyle(
                      color: CustomColors.firebaseGrey,
                      fontSize: 20.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.numberWithOptions(),
                    controller: _data3Controller,
                    validator: (value) => Validator.validateField(
                      value: value!,
                    ),
                    onSaved: (value) {
                      _data3Controller.text = value!;
                    },
                    decoration: InputDecoration(
                      suffix: Text('/ นาที'),
                      labelStyle: TextStyle(fontSize: 18),
                      border: OutlineInputBorder(),
                      filled: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pushNamed(
                                context, '/detail pressure'),
                            child: Text(
                              'ความดันระดับไหนถึงผิดปกติ ?',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  if (_isProcessing)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          CustomColors.firebaseOrange,
                        ),
                      ),
                    )
                  else
                    recordButton,
                ],
              ),
            ),
          ),
        ],
      ),
      //backgroundColor: Color(0xFF73AEF5)
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> _createEdit_pressure() async {
    // print(dateUTC + ' ' + date_Time + ':00');

    FirebaseFirestore.instance
        .collection('edit_pressure')
        .doc(user!.email)
        .collection('all')
        .doc()
        .set(
      {
        'data_title': _data1Controller.text,
        'data_description': _data2Controller.text,
        'data_heartrate': _data3Controller.text,
        'Adata_time': DateTime.now(),
      },
      SetOptions(merge: true),
    );
  }

  _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
    );

    if (date != null)
      setState(() {
        pickedDate = date;
        String formattedDate = DateFormat('dd-MMMM-yyyy').format(pickedDate);
        _dateController.text = formattedDate;
        dateUTC = DateFormat('yyyy-MMMM-dd').format(pickedDate);
      });
  }

  _pickTime() async {
    // ignore: unused_local_variable
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(context: context, initialTime: time);

    if (newTime == null) return;
    setState(() {
      time = newTime;
    });
  }
}
