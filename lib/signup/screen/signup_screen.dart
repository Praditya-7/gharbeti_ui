import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/auth/auth_service.dart';
import 'package:gharbeti_ui/login/screen/login_screen.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:gharbeti_ui/signup/entity/Users.dart';
import 'package:intl/intl.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class SignUpScreen extends StatefulWidget {
  static String route = '/signupScreen';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SignUpScreen> {
  bool isLoading = false;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _dateOfBirth = TextEditingController();

  String selectedUserType = 'owner';
  double height = 0.0;
  double width = 0.0;
  String selectedGender = 'Male';

  // CollectionReference users = _fireStore.collection('users');

  @override
  Widget build(BuildContext context) => initWidget();

  Widget initWidget() {
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal!;
    height = SizeConfig.safeBlockVertical!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorData.primaryColor,
        title: const Text(
          "Register",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? Center(
              child: Container(
                height: 20,
                width: 30,
                child: const CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE)),
                      ],
                    ),
                    child: TextField(
                      controller: _name,
                      cursorColor: const Color(0xff09548c),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Color(0xff09548c),
                        ),
                        hintText: "Full Name",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.person_pin,
                              color: Color(0xff09548c),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Gender',
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 16),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(
                                  () {
                                    selectedGender = 'Male';
                                  },
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                  color: selectedGender == 'Male'
                                      ? const Color(0xff09548c)
                                      : const Color(0xffEEEEEE),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Male',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: selectedGender == 'Male'
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(
                                  () {
                                    selectedGender = 'Female';
                                  },
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  color: selectedGender == 'Female'
                                      ? Color(0xff09548c)
                                      : Color(0xffEEEEEE),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(10.0),
                                  child: Text(
                                    'Female',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: selectedGender == 'Female'
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE)),
                      ],
                    ),
                    child: TextField(
                      controller: _email,
                      cursorColor: Color(0xff09548c),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Color(0xff09548c),
                        ),
                        hintText: "Email",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xffEEEEEE),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 20),
                            blurRadius: 100,
                            color: Color(0xffEEEEEE)),
                      ],
                    ),
                    child: TextField(
                      controller: _phone,
                      cursorColor: Color(0xff09548c),
                      decoration: InputDecoration(
                        focusColor: Color(0xff09548c),
                        icon: Icon(
                          Icons.phone,
                          color: Color(0xff09548c),
                        ),
                        hintText: "Phone Number",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xffEEEEEE),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 20),
                            blurRadius: 100,
                            color: Color(0xffEEEEEE)),
                      ],
                    ),
                    child: TextField(
                      onTap: () async {
                        DateTime date = DateTime(1900);
                        FocusScope.of(context).requestFocus(FocusNode());

                        date = (await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100)))!;

                        _dateOfBirth.text = convertDate(date);
                      },
                      controller: _dateOfBirth,
                      cursorColor: Color(0xff09548c),
                      decoration: InputDecoration(
                        focusColor: Color(0xff09548c),
                        icon: Icon(
                          Icons.calendar_today,
                          color: Color(0xff09548c),
                        ),
                        hintText: "Date of Birth",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xffEEEEEE),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 20),
                            blurRadius: 100,
                            color: Color(0xffEEEEEE)),
                      ],
                    ),
                    child: TextField(
                      controller: _password,
                      obscureText: true,
                      cursorColor: Color(0xff09548c),
                      decoration: InputDecoration(
                        focusColor: Color(0xff09548c),
                        icon: Icon(
                          Icons.vpn_key,
                          color: Color(0xff09548c),
                        ),
                        hintText: "Enter Password",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                selectedUserType = 'owner';
                              },
                            );
                          },
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 20, right: 5, top: 20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                              color: selectedUserType == 'owner'
                                  ? Color(0xff09548c)
                                  : Color(0xffEEEEEE),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              child: Text(
                                'Owner',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: selectedUserType == 'owner'
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                selectedUserType = 'tenant';
                              },
                            );
                          },
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 5, right: 20, top: 20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                              color: selectedUserType == 'tenant'
                                  ? Color(0xff09548c)
                                  : Color(0xffEEEEEE),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              child: Text(
                                'Tenant',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: selectedUserType == 'tenant'
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                        setData();
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 50),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      height: 54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff09548c),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: Color(0xffEEEEEE)),
                        ],
                      ),
                      child: const Text(
                        "REGISTER",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Have Already Member?  "),
                        GestureDetector(
                          child: const Text(
                            "Login Now",
                            style: TextStyle(color: Color(0xff09548c)),
                          ),
                          onTap: () {
                            // Write Tap Code Here.
                            Navigator.pushNamed(context, LoginScreen.route);
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  void setData() async {
    var model = Users(
      name: _name.text.toString(),
      email: _email.text.toString(),
      phone: _phone.text.toString(),
      password: _password.text.toString(),
      dateOfBirth: _dateOfBirth.text.toString(),
      type: selectedUserType,
      roomName: "",
      pdfLink: "",
      gender: selectedGender,
      fileName: "",
    );
    var query = _fireStore.collection('Users').get();
    await query.then((value) {
      Map<String, dynamic> addUser = {};
      if (value.docs.isEmpty) {
        addUser = addData(model);
      } else {
        var count = 0;
        for (int i = 0; i < value.docs.length; i++) {
          var email = value.docs[i]["Email"];
          var password = value.docs[i]["Password"];
          if (model.email == email && model.password == password) {
            count += 1;
            break;
          }
        }
        if (count > 0) {
          setState(() {
            isLoading = false;
          });
          //show message
        } else {
          addUser = addData(model);
        }
      }
      _fireStore.collection('Users').add(addUser).then((value) {
        print("Data Updated");
        setState(() {
          isLoading = false;
        });
      }).catchError((error) {
        print("Failed to add data: $error");
        setState(() {
          isLoading = false;
        });
      });
    });
    //New Code
    try {
      final newUser = await AuthService.createAccount(
          _email.text.toString(), _password.text.toString());
      if (newUser != null) {
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> addData(Users model) {
    Map<String, dynamic> data = <String, dynamic>{
      "Name": model.name,
      "Gender": model.gender,
      "Email": model.email,
      "Password": model.password,
      "Phone Number": model.phone,
      "Type": model.type,
      "Date of Birth": model.dateOfBirth,
      "Room Name": model.roomName,
      "PDFLink": model.pdfLink,
      "FileName": model.fileName,
    };
    return data;
  }

  String convertDate(DateTime date) {
    return DateFormat("yyyy-MM-dd").format(date);
  }
}
