import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../login/loginMail/loginmail_screen.dart';
import '../../model/user_model.dart';

class UserFormScreen extends StatefulWidget {
  static const routeName = '/user-form';

  const UserFormScreen({Key? key}) : super(key: key);

  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  UserModel user = new UserModel();
  bool loading = true;
  FirebaseAuth auth = FirebaseAuth.instance;

  final _formkey = GlobalKey<FormState>();

  final emailEditingController = TextEditingController();
  final firstNameEditingController = TextEditingController();
  final numberHNEditingController = TextEditingController();
  final oPasswordEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final cPasswordEditingController = TextEditingController();
  final addressEditingController = TextEditingController();
  final congenitalDiseaseEditingController = TextEditingController();
  final drugAllergyEditingController = TextEditingController();

  bool showOPassword = true;
  bool showPassword = true;
  bool showCPassword = true;

  @override
  void initState() {
    super.initState();
    onLoadUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onLoadUser() {
    auth.authStateChanges().listen((event) async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(event?.uid)
          .get()
          .then((value) {
        setState(() {
          user = UserModel.fromMap(value.data());

          user.firstName = event?.displayName;
          user.email = event?.email;

          firstNameEditingController.text = user.firstName.toString();
          numberHNEditingController.text = user.numberHN.toString();
          emailEditingController.text = user.email.toString();
          addressEditingController.text = user.address.toString();
          congenitalDiseaseEditingController.text =
              user.congenitalDisease.toString();
          drugAllergyEditingController.text = user.drugAllergy.toString();

          loading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขข้อมูล'),
        actions: [
          IconButton(onPressed: () => onSave(), icon: Icon(Icons.check)),
        ],
      ),
      body: loading
          ? Center(child: CupertinoActivityIndicator(radius: 10))
          : SafeArea(
              child: SingleChildScrollView(
                  child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.all(30),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                            autofocus: false,
                            controller: firstNameEditingController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{3,}$');
                              if (value!.isEmpty) {
                                return ("กรุณาใส่ชื่อ - นามสกุล");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("กรุณาใส่ชื่อ - นามสกุล ให้ถูกต้อง(Min. 3 Character)");
                              }
                              return null;
                            },
                            onSaved: (value) => user.firstName = value?.trim(),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_circle),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "ชื่อ - นามสกุล",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                        SizedBox(height: 10),
                        TextFormField(
                            autofocus: false,
                            controller: numberHNEditingController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("กรุณาใส่หมายเลข HN");
                              }
                              return null;
                            },
                            onSaved: (value) => user.numberHN = value,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_circle),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "หมายเลข HN",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                        SizedBox(height: 10),
                        TextFormField(
                            autofocus: false,
                            controller: emailEditingController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("กรุณาใส่อีเมลของคุณ");
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("กรุณาใส่อีเมลของคุณให้ถูกต้อง");
                              }
                              return null;
                            },
                            onSaved: (value) => user.email = value,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.mail),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                        SizedBox(height: 10),
                        Divider(thickness: 1),
                        SizedBox(height: 10),
                        TextFormField(
                            autofocus: false,
                            controller: addressEditingController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("กรุณากรอกข้อมูล");
                              }
                              return null;
                            },
                            onSaved: (value) => user.address = value,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_circle),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "ที่อยู่",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                        SizedBox(height: 10),
                        TextFormField(
                            autofocus: false,
                            controller: congenitalDiseaseEditingController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("กรุณากรอกข้อมูล");
                              }
                              return null;
                            },
                            onSaved: (value) => user.congenitalDisease = value,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_circle),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "โรคประจำตัว",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                        SizedBox(height: 10),
                        TextFormField(
                            autofocus: false,
                            controller: drugAllergyEditingController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("กรุณากรอกข้อมูล");
                              }
                              return null;
                            },
                            onSaved: (value) => user.drugAllergy = value,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_circle),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "การแพ้ยา",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                        SizedBox(height: 10),
                        Divider(thickness: 1),
                        SizedBox(height: 10),
                        Text('** ถ้าไม่เปลี่ยนรหัสผ่านให้เว้นว่างไว้ **'),
                        SizedBox(height: 10),
                        TextFormField(
                            autofocus: false,
                            controller: oPasswordEditingController,
                            obscureText: showOPassword,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return ("กรุณาใส่หรัสผ่านของคุณ");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("กรุณาใส่รหัสผ่านให้ถูกต้อง(Min. 6 Character)");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              oPasswordEditingController.text = value!;
                            },
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(showOPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    showOPassword = !showOPassword;
                                  });
                                },
                              ),
                              prefixIcon: Icon(Icons.lock),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "Old Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                        SizedBox(height: 10),
                        TextFormField(
                            autofocus: false,
                            controller: passwordEditingController,
                            obscureText: showPassword,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return ("กรุณาใส่หรัสผ่านของคุณ");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("กรุณาใส่รหัสผ่านให้ถูกต้อง(Min. 6 Character)");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              passwordEditingController.text = value!;
                            },
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(showPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                              ),
                              prefixIcon: Icon(Icons.lock),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                        SizedBox(height: 10),
                        TextFormField(
                            autofocus: false,
                            controller: cPasswordEditingController,
                            obscureText: showCPassword,
                            validator: (value) {
                              if (cPasswordEditingController.text !=
                                  passwordEditingController.text) {
                                return "รหัสผ่านไม่ตรงกัน";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              cPasswordEditingController.text = value!;
                            },
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(showCPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    showCPassword = !showCPassword;
                                  });
                                },
                              ),
                              prefixIcon: Icon(Icons.lock),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "Confirm Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              )),
            ),
    );
  }

  Future<void> onSave() async {
    FocusScope.of(context).unfocus();
    setState(() {});
    _formkey.currentState!.save();

    String name = firstNameEditingController.text;
    String numberHN = numberHNEditingController.text;
    String email = emailEditingController.text;

    String oPassword = oPasswordEditingController.text;
    String password = passwordEditingController.text;
    String cPassword = cPasswordEditingController.text;
    bool checkPassword = false;

    if (oPassword != '') {
      if (password != '' && cPassword != '') {
        if (password != cPassword) {
          Fluttertoast.showToast(msg: "รหัสผ่านกับยืนยันรหัสผ่าน ไม่ตรงกัน");
        } else if (oPassword != user.password) {
          Fluttertoast.showToast(msg: "รหัสผ่านเก่า ไม่ถูกต้อง");
        } else {
          user.password = password;
          checkPassword = true;
        }
      }
    }

    if (name != '' && numberHN != '' && email != '') {
      await auth.currentUser?.updateDisplayName(user.firstName);
      await auth
          .signInWithEmailAndPassword(
              email: auth.currentUser!.email!,
              password: checkPassword ? oPassword : user.password!)
          .then((value) async {
        await value.user!.updateEmail(email);
        await value.user!.updatePassword(user.password!);
      });

      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .update(user.toMap())
          .then((value) {
        if (checkPassword) {
          auth.signOut().then((value) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()),
                ModalRoute.withName('/'),
              ));
        } else {
          Navigator.of(context).pop();
        }
      });
    } else {
      Fluttertoast.showToast(msg: "กรอกข้อมูลไม่ครบ");
    }
  }
}
