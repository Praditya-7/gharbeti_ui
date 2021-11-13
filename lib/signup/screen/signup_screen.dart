import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/login/screen/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static String route = '/signupScreen';

  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SignUpScreen> {
  bool isLoading = false;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();

  String selectedUserType = 'Owner';
  @override
  Widget build(BuildContext context) => initWidget();

  Widget initWidget() {
    return Scaffold(
        body: isLoading
            ? Center(
                child: Container(
                  height: 20,
                  width: 30,
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                children: [
                  Container(
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Image.asset(
                            "assets/images/logo.png",
                            height: 90,
                            width: 90,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20, top: 20),
                          alignment: Alignment.center,
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black45,
                            ),
                          ),
                        )
                      ],
                    )),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
                      ],
                    ),
                    child: TextField(
                      controller: _name,
                      cursorColor: Color(0xff09548c),
                      decoration: InputDecoration(
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
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
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
                        BoxShadow(offset: Offset(0, 20), blurRadius: 100, color: Color(0xffEEEEEE)),
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
                        BoxShadow(offset: Offset(0, 20), blurRadius: 100, color: Color(0xffEEEEEE)),
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
                                selectedUserType = 'Owner';
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 5, top: 20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                              color: selectedUserType == 'Owner'
                                  ? Color(0xff09548c)
                                  : Color(0xffEEEEEE),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              child: Text(
                                'Owner',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
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
                                selectedUserType = 'Tenant';
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 5, right: 20, top: 20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                              color: selectedUserType == 'Tenant'
                                  ? Color(0xff09548c)
                                  : Color(0xffEEEEEE),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              child: Text(
                                'Tenant',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      // Write Click Listener Code Here.
                      final name = _name.text;
                      final email = _email.text;
                      final phone = _phone.text;
                      final pass = _password.text;
                      final type = selectedUserType;
                      // try {
                      //   final newUser =
                      //       await AuthService.createAccount(name, email, phone, pass, type);
                      //   if (newUser != null) {
                      //     Navigator.pushNamed(context, ConfirmEmail.route);
                      //   }
                      // } catch (e) {
                      //   print(e);
                      // }
                    },
                    child: InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 50),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        height: 54,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff09548c),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
                          ],
                        ),
                        child: Text(
                          "REGISTER",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Have Already Member?  "),
                        GestureDetector(
                          child: Text(
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
              )));
  }
}
