import 'package:flutter/material.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/progress_indicator_widget.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:gharbeti_ui/signup/screen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static String route = '/loginScreen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  double width = 0.0;
  double height = 0.0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal!;
    height = SizeConfig.safeBlockVertical!;
    return initWidget();
  }

  initWidget() {
    return Scaffold(
        body: Stack(
      children: [
        _createBody(),
        Visibility(visible: isLoading, child: CustomProgressIndicatorWidget())
      ],
    ));
  }

  Widget _createBody() {
    return SingleChildScrollView(
        child: Container(
      width: double.infinity,
      height: height * 130,
      color: const Color(ColorData.primaryColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: Image.asset(
              "assets/image/logo_image.png",
              height: 250,
              width: 250,
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              ),
              child: _createLoginBody(),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _createLoginBody() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 20, top: 20),
          alignment: Alignment.center,
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 24, color: Colors.black45),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
          padding: const EdgeInsets.only(left: 20, right: 20),
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            //border: Border.all(color: new Color(0xff09548c), width: 1),
            color: Colors.grey[200],
            boxShadow: const [
              BoxShadow(offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
            ],
          ),
          child: TextField(
            controller: _email,
            cursorColor: const Color(0xff09548c),
            decoration: const InputDecoration(
              icon: Icon(
                Icons.email,
                color: Color(0xff09548c),
              ),
              hintText: "Enter Email",
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          padding: const EdgeInsets.only(left: 20, right: 20),
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            //border: Border.all(color: new Color(0xff09548c), width: 1),
            color: const Color(0xffEEEEEE),
            boxShadow: const [
              BoxShadow(offset: Offset(0, 20), blurRadius: 100, color: Color(0xffEEEEEE)),
            ],
          ),
          child: TextField(
            controller: _password,
            obscureText: true,
            cursorColor: const Color(0xff09548c),
            decoration: const InputDecoration(
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
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              // Write Click Listener Code Here
              // Navigator.of(context)
              //     .pushReplacementNamed(ForgotPassword.route);
            },
            child: const Text("Forgot Password?"),
          ),
        ),
        GestureDetector(
          onTap: () async {
            // Write Click Listener Code Here.
            final email = _email.text;
            final pass = _password.text;
            // checkLogin(email, pass);
          },
          child: InkWell(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: 54,
              decoration: BoxDecoration(
                color: const Color(0xff09548c),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
                ],
              ),
              child: const Text(
                "Sign In",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Not have an account yet?  "),
              GestureDetector(
                child: const Text(
                  "Create Account",
                  style: TextStyle(color: Color(0xff09548c)),
                ),
                onTap: () {
                  Navigator.pushNamed(context, SignUpScreen.route); // Write Tap Code Here.
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  // void checkLogin(String email, String pass) async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   if (email.isEmpty && pass.isEmpty) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     showErrorMessage("Email and password can not be empty", context);
  //   } else if (email.isEmpty) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     showErrorMessage("Email can not be empty", context);
  //   } else if (pass.isEmpty) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     showErrorMessage("Password can not be empty", context);
  //   } else
  //     try {
  //       final user = await AuthService.loginWithEmail(email, pass, context);
  //       setState(() {
  //         isLoading = false;
  //       });
  //       if (user != null) {
  //         if (user.emailVerified) {
  //           final pref = await SharedPreferences.getInstance();
  //           pref.setBool('login', true);
  //           Navigator.of(context).pushReplacementNamed(HomepageScreen.route);
  //         } else
  //           showErrorMessage("Please verify your email for login", context);
  //       } else {
  //         showErrorMessage("Invalid email or password", context);
  //       }
  //     } catch (e) {
  //       print(e);
  //     }
  // }

  Widget showErrorMessage(String message, BuildContext context) {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (message != null && message.isNotEmpty) {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: SingleChildScrollView(child: Text(message)),
              actions: <Widget>[
                Builder(builder: (BuildContext outerContext) {
                  return TextButton(
                    child: const Text('Okay'),
                    onPressed: () {
                      Navigator.of(outerContext).pop();
                    },
                  );
                }),
              ],
            );
          },
        );
      }
    });

    return const SizedBox.shrink();
  }
}
