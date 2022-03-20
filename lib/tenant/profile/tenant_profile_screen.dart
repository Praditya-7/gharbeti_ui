// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/login/screen/login_screen.dart';
import 'package:gharbeti_ui/owner/listings/entity/user_container.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:gharbeti_ui/tenant/profile/add_document.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class ProfileTenantScreen extends StatefulWidget {
  const ProfileTenantScreen({Key? key}) : super(key: key);

  @override
  _ProfileTenantScreenState createState() => _ProfileTenantScreenState();
}

class _ProfileTenantScreenState extends State<ProfileTenantScreen> {
  bool _toggleDarkMode = false;
  bool _toggleNotifications = false;
  List<User> userDataList = [];
  User userData = User();
  bool isLoading = true;
  double width = 0.0;
  double height = 0.0;
  var div = Divider(
    thickness: 0.9,
  );

  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() async {
    final pref = await SharedPreferences.getInstance();
    var email = pref.getString("email");

    var query1 =
        _fireStore.collection('Users').where("Email", isEqualTo: email).get();
    await query1.then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          userDataList.add(User.fromFireStoreSnapshot(doc));
        }
      }
    }).catchError((e) {
      print(e);
    });

    setState(() {
      userData = userDataList.first;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal!;
    height = SizeConfig.safeBlockVertical!;
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListTile(
                    leading: Container(
                      width: 75,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/image/avatar.png"),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    title: Text(userData.name.toString()),
                    subtitle: Text(userData.email.toString()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GetListTile(
                    onTap: () {
                      //ROUTE CODE HERE
                    },
                    title: 'Edit Profile',
                    leadingIconData: Icons.person_pin,
                    trailingIconData: CupertinoIcons.chevron_forward,
                  ),
                  div,
                  GetListTile(
                    onTap: () {
                      //ROUTE CODE HERE
                    },
                    title: 'Preferences',
                    leadingIconData: CupertinoIcons.slider_horizontal_3,
                    trailingIconData: CupertinoIcons.chevron_forward,
                  ),
                  div,
                  SizedBox(
                    height: 40,
                    child: SwitchListTile(
                      activeColor: Color(0xff09548c),
                      title: Text(
                        'Notifications',
                        style: TextStyle(
                          color: Color(0xff09548c),
                        ),
                      ),
                      value: _toggleNotifications,
                      onChanged: (bool value) {
                        setState(() {
                          _toggleNotifications = value;
                        });
                      },
                      secondary: Icon(
                        Icons.notifications_none,
                        color: Color(0xff09548c),
                      ),
                    ),
                  ),
                  div,
                  GetListTile(
                    onTap: () {
                      //ROUTE CODE HERE
                      Navigator.of(context).pushNamed(AddDocuments.route);
                    },
                    title: 'Documents',
                    leadingIconData: Icons.folder_open,
                    trailingIconData: CupertinoIcons.chevron_forward,
                  ),
                  div,
                  GetListTile(
                    onTap: () {
                      //ROUTE CODE HERE
                    },
                    title: 'Help Center',
                    trailingIconData: CupertinoIcons.chevron_forward,
                    leadingIconData: Icons.help_center,
                  ),
                  div,
                  GetListTile(
                    onTap: () {
                      //ROUTE CODE HERE
                    },
                    title: 'About',
                    trailingIconData: CupertinoIcons.chevron_forward,
                    leadingIconData: Icons.alternate_email,
                  ),
                  div,
                  GetListTile(
                    onTap: () async {
                      //ROUTE CODE HERE
                      final pref = await SharedPreferences.getInstance();
                      pref.setString('roomName', '');
                      pref.setString('email', '');
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.route);
                    },
                    title: 'Logout',
                    trailingIconData: CupertinoIcons.chevron_forward,
                    leadingIconData: Icons.logout,
                  ),
                  div,
                  Container(
                    width: double.infinity,
                    color: ColorData.primaryColor,
                    height: height * 20,
                    child: Image.asset('assets/image/logo_image.png'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GetListTile extends StatelessWidget {
  final String title;
  final IconData trailingIconData;
  final IconData leadingIconData;
  final VoidCallback onTap;

  const GetListTile(
      {Key? key,
      required this.title,
      required this.trailingIconData,
      required this.leadingIconData,
      required this.onTap})
      : super(key: key);

  // const GetListTile({
  //   Key? key,
  //   required String title,
  //   required IconData trailingIconData,
  //   required IconData leadingIconData,
  //   required VoidCallback onTap,
  // })  : _title = title,
  //       _trailingIconData = trailingIconData,
  //       _leadingIconData = leadingIconData,
  //       _onTap = onTap,
  //       super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListTile(
        enabled: true,
        onTap: onTap,
        leading: Icon(
          leadingIconData,
          color: Color(0xff09548c),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Color(0xff09548c),
          ),
        ),
        trailing: Icon(
          trailingIconData,
          color: Color(0xff09548c),
        ),
      ),
    );
  }
}
