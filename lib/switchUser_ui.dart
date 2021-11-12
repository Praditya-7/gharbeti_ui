// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gharbeti_ui/screens/owner/consistent_ui_owner.dart';
import 'package:gharbeti_ui/screens/tenant/consistent_ui_tenant.dart';


class SwitchUserUI extends StatefulWidget {
  const SwitchUserUI({Key? key}) : super(key: key);

  @override
  _SwitchUserUIState createState() => _SwitchUserUIState();
}

class _SwitchUserUIState extends State<SwitchUserUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xff09548c),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConsistentUIOwner(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
                  child: Center(
                    child: Text(
                      'Owner',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xff09548c),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConsistentUITenant(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
                  child: Center(
                    child: Text(
                      'Tenant',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
