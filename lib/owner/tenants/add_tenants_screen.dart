// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class AddTenantsScreen extends StatefulWidget {
  const AddTenantsScreen({Key? key}) : super(key: key);

  @override
  _AddTenantsScreenState createState() => _AddTenantsScreenState();
}

class _AddTenantsScreenState extends State<AddTenantsScreen> {
  String? listingDropdownValue;
  String? tenantGenderDropdownValue;

  final TextEditingController _tenantID = TextEditingController();
  final TextEditingController _tenantName = TextEditingController();
  final TextEditingController _tenantAddress = TextEditingController();
  final TextEditingController _tenantEmail = TextEditingController();
  final TextEditingController _tenantPhoneNumber = TextEditingController();
  final TextEditingController _tenantEmergencyContact = TextEditingController();
  final TextEditingController _electricityCurrentMeterReading = TextEditingController();
  final TextEditingController _electricityPerUnitCharge = TextEditingController();

  final TextEditingController _waterMonthlyCharge = TextEditingController();
  final TextEditingController _internetCharge = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      appBar: AppBar(
        backgroundColor: Color(0xff09548c),
        title: Text('Add Tenants'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.message),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //General Information
                Text(
                  'General Information',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Tenant ID
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: TextField(
                          controller: _tenantID,
                          cursorColor: Color(0xff09548c),
                          decoration: InputDecoration(
                            hintText: "Tenant ID*",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      // Tenant Name
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: TextField(
                          controller: _tenantName,
                          cursorColor: Color(0xff09548c),
                          decoration: InputDecoration(
                            hintText: "Tenant Name*",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      //Tenant Address
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: TextField(
                          controller: _tenantAddress,
                          cursorColor: Color(0xff09548c),
                          decoration: InputDecoration(
                            hintText: " Address*",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      //Tenant Email
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: TextField(
                          controller: _tenantEmail,
                          cursorColor: Color(0xff09548c),
                          decoration: InputDecoration(
                            hintText: "Email*",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      //Gender
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: Text('Gender*'),
                          underline: Container(
                            height: 0,
                          ),
                          value: tenantGenderDropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              tenantGenderDropdownValue = newValue!;
                            });
                          },
                          icon: Icon(Icons.arrow_drop_down_sharp),
                          items: //Import List
                              <String>[
                            'Male',
                            'Female',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      //Phone Number
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: TextField(
                          controller: _tenantPhoneNumber,
                          cursorColor: Color(0xff09548c),
                          decoration: InputDecoration(
                            hintText: "Phone Number*",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      //Emergency Contact
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: TextField(
                          controller: _tenantEmergencyContact,
                          cursorColor: Color(0xff09548c),
                          decoration: InputDecoration(
                            hintText: "Emergency Contact*",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),

                      //Select Listing
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: Text('Select Listing*'),
                          underline: Container(
                            height: 0,
                          ),
                          value: listingDropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              listingDropdownValue = newValue!;
                            });
                          },
                          icon: Icon(Icons.arrow_drop_down_sharp),
                          items: //Import List
                              <String>[
                            '101',
                            '102',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      //
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Electricity Charges',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: TextField(
                          controller: _electricityPerUnitCharge,
                          cursorColor: Color(0xff09548c),
                          decoration: InputDecoration(
                            hintText: "Per Unit Charge(in Rs)* ",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      //Last Meter Reading
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: TextField(
                          controller: _electricityCurrentMeterReading,
                          cursorColor: Color(0xff09548c),
                          decoration: InputDecoration(
                            hintText: "Current Meter Reading*",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Water Charge
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Water Charges',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: TextField(
                          controller: _waterMonthlyCharge,
                          cursorColor: Color(0xff09548c),
                          decoration: InputDecoration(
                            hintText: "Monthly Charge(in Rs)* ",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Internet Charge
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Internet Charges',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: TextField(
                          controller: _internetCharge,
                          cursorColor: Color(0xff09548c),
                          decoration: InputDecoration(
                            hintText: "Monthly Charge(in Rs)* ",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xff09548c),
                  ),
                  child: InkWell(
                    onTap: () {
                      //Add Tenant to Firebase Function
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
                      child: Center(
                        child: Text(
                          'Add Tenant',
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
        ),
      ),
    );
  }
}
