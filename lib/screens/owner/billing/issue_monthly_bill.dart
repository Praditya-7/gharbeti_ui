// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IssueMonthlyBill extends StatefulWidget {
  const IssueMonthlyBill({Key? key}) : super(key: key);

  @override
  _IssueMonthlyBillState createState() => _IssueMonthlyBillState();
}

class _IssueMonthlyBillState extends State<IssueMonthlyBill> {
  String? listingDropdownValue;
  String? billMonthDropdownValue = 'January';
  int rentCharge = 9000;
  int? dueRemaining = 0;
  int perUnitElectricityCharge = 15;
  int lastMeterReading = 230;
  int diff = 0;
  int current = 0;
  int cost = 0;
  int waterCharge = 500;
  int internetCharge = 1500;
  int total = 0;

  final TextEditingController currentMeterReading = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      appBar: AppBar(
        backgroundColor: Color(0xff09548c),
        title: Text('Issue Bill'),
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
                Text(
                  'Billing Detail',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                //Billing Detail Start
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Select Tenant
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: Text('Select Tenant*'),
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
                            'Sarthak Shrestha 104',
                            'Praditya Manandhar 105',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      //Select Tenant End
                      //Bill Month Start
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Bill Month'),
                            DropdownButton<String>(
                              underline: Container(
                                height: 0,
                              ),
                              value: billMonthDropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  billMonthDropdownValue = newValue!;
                                });
                              },
                              icon: Icon(Icons.arrow_drop_down_sharp),
                              items: <String>[
                                'January',
                                'February',
                                'March',
                                'April',
                                'May',
                                'June',
                                'July',
                                'August',
                                'September',
                                'October',
                                'November',
                                'December',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      //Bill Month End
                      //Monthly Rent Start
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        padding: EdgeInsets.fromLTRB(18, 18, 30, 18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Monthly Rent'),
                            Text('Rs. ' + rentCharge.toString()),
                          ],
                        ),
                      ),
                      //Monthly Rent End
                      //Remaining Dues
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        padding: EdgeInsets.fromLTRB(18, 18, 30, 18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Remaining Dues'),
                            Text('Rs. ' + dueRemaining.toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //Billing Detail End
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Electricity Charge',
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
                      //Per Unit Charge
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        padding: EdgeInsets.fromLTRB(18, 18, 30, 18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Per Unit Charge(in Rs.)'),
                            Text('Rs. ' + perUnitElectricityCharge.toString()),
                          ],
                        ),
                      ),
                      //Last Meter Reading
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        padding: EdgeInsets.fromLTRB(18, 18, 30, 18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Last Meter Reading'),
                            Text(lastMeterReading.toString()),
                          ],
                        ),
                      ),
                      //Current Meter Reading
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        padding: EdgeInsets.fromLTRB(18, 2, 30, 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Current Meter Reading'),
                            SizedBox(
                              width: 100,
                              child: TextField(
                                textAlign: TextAlign.end,
                                keyboardType: TextInputType.number,
                                controller: currentMeterReading,
                                cursorColor: Color(0xff09548c),
                                onChanged: (value) {
                                  setState(() {
                                    current = int.parse(currentMeterReading.text);
                                    diff = current - lastMeterReading;
                                    cost = diff * perUnitElectricityCharge;
                                    total = cost + waterCharge + internetCharge + rentCharge;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: "Enter Here",
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Consumed Unit
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        padding: EdgeInsets.fromLTRB(18, 18, 30, 18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Consumed Unit'),
                            Text(diff.toString()),
                          ],
                        ),
                      ),
                      //Total Cost
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        padding: EdgeInsets.fromLTRB(18, 18, 30, 18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Cost'),
                            Text('Rs.' + cost.toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //End of Electricity Charge
                //Water Charge
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Water Charge',
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
                      //Water Charge
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        padding: EdgeInsets.fromLTRB(18, 18, 30, 18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Water Charge'),
                            Text('Rs. ' + waterCharge.toString()),
                          ],
                        ),
                      ),
                      //Last Meter Reading
                    ],
                  ),
                ),

                //End of Water Charge
                //Internet Charge
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Internet Charge',
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
                      //Water Charge
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        padding: EdgeInsets.fromLTRB(18, 18, 30, 18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Internet Charge'),
                            Text('Rs. ' + internetCharge.toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //End of Internet Charge
                SizedBox(
                  height: 5,
                ),
                //Total
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.green,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
                    child: Center(
                      child: Text(
                        'Total Rs.' + total.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                //Issue to Tenant
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xff09548c),
                  ),
                  child: InkWell(
                    onTap: () {
                      //ADD ISSUE CODE
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
                      child: Center(
                        child: Text(
                          'Issue to Tenant',
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
// Container(
//   margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
//   padding: EdgeInsets.only(left: 20, right: 20),
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(5),
//     color: Colors.grey[200],
//   ),
//   child: TextField(
//     controller: _selectDate, //editing controller of this TextField
//     decoration: InputDecoration(
//       suffixIcon: Icon(Icons.calendar_today),
//
//       hintText: "Due Date",
//       enabledBorder: InputBorder.none,
//       focusedBorder: InputBorder.none, //icon of text field
//       //label text of field
//     ),
//     readOnly: true, //set it true, so that user will not able to edit text
//     onTap: () async {
//       DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(
//             1950), //DateTime.now() - not to allow to choose before today.
//         lastDate: DateTime(2100),
//       );
//
//       if (pickedDate != null) {
//         String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//         setState(() {
//           _selectDate.text =
//               formattedDate; //set output date to TextField value.
//         });
//       } else {
//         print("Date is not selected");
//       }
//     },
//   ),
// ),
