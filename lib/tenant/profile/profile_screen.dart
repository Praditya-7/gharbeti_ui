// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/login/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTenantScreen extends StatefulWidget {
  const ProfileTenantScreen({Key? key}) : super(key: key);

  @override
  _ProfileTenantScreenState createState() => _ProfileTenantScreenState();
}

class _ProfileTenantScreenState extends State<ProfileTenantScreen> {
  bool _toggleDarkMode = false;
  bool _toggleNotifications = false;
  late String name = 'Sarthak Shrestha';
  late String email = 'stha.sarthak@gmail.com';
  var div = Divider(
    thickness: 0.9,
  );

  @override
  Widget build(BuildContext context) {
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
                          image: NetworkImage(
                            'https://googleflutter.com/sample_image.jpg',
                          ),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    title: Text(name),
                    subtitle: Text(email),
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
                    },
                    title: 'File Manager',
                    leadingIconData: Icons.folder_open,
                    trailingIconData: CupertinoIcons.chevron_forward,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
              padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
              color: Colors.white,
              child: Column(
                children: [
                  GetListTile(
                    onTap: () {
                      //ROUTE CODE HERE
                    },
                    title: 'Language Settings',
                    trailingIconData: CupertinoIcons.chevron_forward,
                    leadingIconData: Icons.language,
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
                  SizedBox(
                    height: 10,
                  ),
                  div,
                  GetListTile(
                    onTap: () async {
                      //ROUTE CODE HERE
                      final pref = await SharedPreferences.getInstance();
                      pref.setString('roomName', '');
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.route);
                    },
                    title: 'Logout',
                    trailingIconData: CupertinoIcons.chevron_forward,
                    leadingIconData: Icons.logout,
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
