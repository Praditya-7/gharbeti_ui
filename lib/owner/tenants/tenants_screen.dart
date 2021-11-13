// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/tenants/tenant_detail.dart';

import 'add_tenants_screen.dart';

class TenantsScreen extends StatefulWidget {
  static String route = '/tenantScreen';
  const TenantsScreen({Key? key}) : super(key: key);

  @override
  _TenantsScreenState createState() => _TenantsScreenState();
}

class _TenantsScreenState extends State<TenantsScreen> {
  List<String> entries = <String>[
    '1',
    '2',
    '3',
  ];

  String tenantName = 'Ram Shrestha';
  String listingType = 'Flat';
  List<int> dueRemaining = [
    15000,
    0,
    1600,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color(0xff09548c),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTenantsScreen()),
          );
        },
      ),
      body: SafeArea(
        child: ListView.separated(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: entries.length,
          separatorBuilder: (BuildContext context, int index) => Divider(
            height: 0.1,
            indent: 0,
            thickness: 0.1,
          ),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TenantDetail()),
                );
              },
              child: Container(
                margin: EdgeInsets.all(12),
                height: 140,
                color: Colors.white,
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.person,
                          color: Color(0xff09548c),
                          size: 100,
                        ),
                        Text(
                          tenantName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          listingType + ' No ' + entries[index],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Due: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              //ERROR HERE IN DUE VALUE
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: (dueRemaining[index] == 0)
                                    ? Color(0xff30d472)
                                    : Colors.orange,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    dueRemaining[index].toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
