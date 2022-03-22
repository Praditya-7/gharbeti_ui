// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gharbeti_ui/notification/entity/notification_container.dart';
import 'package:gharbeti_ui/owner/billing/entity/billing_container.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';
import 'package:gharbeti_ui/owner/listings/service/storage_service.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/progress_indicator_widget.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class IssueMonthlyBill extends StatefulWidget {
  const IssueMonthlyBill({Key? key}) : super(key: key);

  @override
  _IssueMonthlyBillState createState() => _IssueMonthlyBillState();
}

class _IssueMonthlyBillState extends State<IssueMonthlyBill> {
  Billings document = Billings();
  String pdfURL = '';
  String randomFileName = '';
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();
  String listingNo = '';
  List<String?> listingNoList = [];
  bool isLoading = true;
  int? index;
  String? tenantDropdownValue;
  String? billMonthDropdownValue = 'January';
  int rentCharge = 0;
  int? dueRemaining = 0;
  int perUnitElectricityCharge = 0;
  int lastMeterReading = 0;
  int consumedUnit = 0;
  int current = 0;
  int electricityCost = 0;
  int waterCharge = 0;
  int internetCharge = 0;
  int total = 0;
  List<Room> roomList = [];
  List<Room> occupiedList = [];
  List<String?> tenantList = [];
  List<String?> rentList = [];
  List<String?> lastMeterReadingList = [];
  double height = 0.0;
  double width = 0.0;
  final TextEditingController currentMeterReadingController =
      TextEditingController();
  final TextEditingController perUnitChargeController = TextEditingController();
  final TextEditingController waterChargeController = TextEditingController();
  final TextEditingController internetController = TextEditingController();

  final pdf = pw.Document();

  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() async {
    roomList.clear();
    final pref = await SharedPreferences.getInstance();
    var email = pref.getString("email");
    var query = _fireStore
        .collection('Rooms')
        .where("OwnerEmail", isEqualTo: email)
        .get();
    await query.then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          roomList.add(Room.fromFireStoreSnapshot(doc));
        }
      }
    });
    occupiedList.clear();
    for (var item in roomList) {
      if (item.status == "Occupied") {
        occupiedList.add(item);
        tenantList.add(item.tenantEmail);
        listingNoList.add(item.listingNo);
        lastMeterReadingList.add(item.lastMeterReading);
        rentList.add(item.rent);
        print(tenantList[0]);
      }
    }
    setState(() {
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
      appBar: AppBar(
        backgroundColor: Color(0xff09548c),
        title: Text('Issue Bill'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: ColorData.primaryColor,
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      child: BuildText(
                        text: "Billing Detail",
                        color: Colors.white,
                      ),
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
                            padding: EdgeInsets.only(left: 40, right: 40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200],
                            ),
                            child: DropdownButton<String>(
                              menuMaxHeight: height * 20,
                              isExpanded: true,
                              hint: Text(
                                'Select Tenant*',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              underline: Container(
                                height: 0,
                              ),
                              value: tenantDropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  tenantDropdownValue = newValue!;
                                  for (int i = 0; i < tenantList.length; i++) {
                                    if (tenantDropdownValue == tenantList[i]) {
                                      index = i;
                                    }
                                  }
                                  rentCharge =
                                      int.parse(rentList[index!].toString());
                                  print(rentCharge);
                                  listingNo = listingNoList[index!].toString();
                                  lastMeterReading = int.parse(
                                      lastMeterReadingList[index!].toString());
                                });
                              },
                              icon: Icon(Icons.arrow_drop_down_sharp),
                              items: tenantList.map((String? value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value!),
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
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
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
                    Container(
                      color: ColorData.primaryColor,
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      child: BuildText(
                        text: "Electricity Charge",
                        color: Colors.white,
                      ),
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
                            padding: EdgeInsets.fromLTRB(18, 2, 30, 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Per Unit Charge(in Rs.)'),
                                SizedBox(
                                  width: 100,
                                  child: TextField(
                                    textAlign: TextAlign.end,
                                    keyboardType: TextInputType.number,
                                    controller: perUnitChargeController,
                                    cursorColor: Color(0xff09548c),
                                    onChanged: (value) {
                                      setState(() {
                                        perUnitElectricityCharge = int.parse(
                                            perUnitChargeController.text);
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
                                    controller: currentMeterReadingController,
                                    cursorColor: Color(0xff09548c),
                                    onChanged: (value) {
                                      setState(() {
                                        current = int.parse(
                                            currentMeterReadingController.text);
                                        consumedUnit =
                                            current - lastMeterReading;
                                        electricityCost = consumedUnit *
                                            perUnitElectricityCharge;
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
                                Text(consumedUnit.toString()),
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
                                Text('Electricity Cost'),
                                Text('Rs.' + electricityCost.toString()),
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
                    Container(
                      color: ColorData.primaryColor,
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      child: BuildText(
                        text: "Water Charge",
                        color: Colors.white,
                      ),
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
                            padding: EdgeInsets.fromLTRB(18, 2, 30, 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Water Charge(in Rs.)'),
                                SizedBox(
                                  width: 100,
                                  child: TextField(
                                    textAlign: TextAlign.end,
                                    keyboardType: TextInputType.number,
                                    controller: waterChargeController,
                                    cursorColor: Color(0xff09548c),
                                    onChanged: (value) {
                                      setState(() {
                                        waterCharge = int.parse(
                                            waterChargeController.text);
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
                        ],
                      ),
                    ),

                    //End of Water Charge
                    //Internet Charge
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: ColorData.primaryColor,
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      child: BuildText(
                        text: "Internet Charge",
                        color: Colors.white,
                      ),
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
                            padding: EdgeInsets.fromLTRB(18, 2, 30, 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Internet Charge(in Rs.)'),
                                SizedBox(
                                  width: 100,
                                  child: TextField(
                                    textAlign: TextAlign.end,
                                    keyboardType: TextInputType.number,
                                    controller: internetController,
                                    cursorColor: Color(0xff09548c),
                                    onChanged: (value) {
                                      setState(() {
                                        internetCharge =
                                            int.parse(internetController.text);

                                        total = electricityCost +
                                            waterCharge +
                                            internetCharge +
                                            rentCharge;
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
                        color: Colors.deepOrangeAccent,
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
                      height: height * 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.green,
                      ),
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            if (tenantDropdownValue == "" ||
                                perUnitElectricityCharge == 0 ||
                                currentMeterReadingController.text == "") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Fill all the details !!!'),
                                ),
                              );
                            } else {
                              isLoading = true;
                              setBillData();
                            }
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(30, 8, 30, 8),
                          child: Center(
                            child: Text(
                              'Issue Bill',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isLoading,
              child: CustomProgressIndicatorWidget(),
            ),
          ],
        ),
      ),
    );
  }

  writeOnPdf(Billings model) async {
    final profileImage = pw.MemoryImage(
        (await rootBundle.load('assets/image/logo_image.png'))
            .buffer
            .asUint8List());
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return pw.Expanded(
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
              pw.Image(profileImage, width: 175, height: 175),
              pw.SizedBox(height: 10.0),
              pw.Text(
                "INVOICE",
                style: pw.TextStyle(
                  fontSize: 28.0,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 15.0),
              //HEADER 1
              pw.Container(
                  child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                      children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Bill To",
                            style: pw.TextStyle(
                              fontSize: 12.0,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            "Invoice No",
                            style: pw.TextStyle(
                              fontSize: 12.0,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            model.tenantEmail.toString(),
                            style: pw.TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                          pw.Text(
                            "101",
                            style: pw.TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ]),
                    pw.SizedBox(height: 10.0),
                    //HEADER 2
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Listing",
                            style: pw.TextStyle(
                              fontSize: 12.0,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            "Month",
                            style: pw.TextStyle(
                              fontSize: 12.0,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            listingNo,
                            style: pw.TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                          pw.Text(
                            model.month.toString(),
                            style: pw.TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ]),
                  ])),
              pw.SizedBox(height: 15.0),
              //METER READING & UNIT COST
              pw.Text(
                  "Meter Reading | Per unit Cost : Rs. ${model.electricityPerUnitCharge}.0",
                  style: pw.TextStyle(
                    fontSize: 12.0,
                    fontWeight: pw.FontWeight.bold,
                  )),
              pw.SizedBox(height: 10.0),
              pw.Container(
                  padding: pw.EdgeInsets.all(10.0),
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(),
                      borderRadius: pw.BorderRadius.circular(5.0)),
                  child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Prev Reading: ${model.lastMeterReading}",
                            style: pw.TextStyle(
                              fontSize: 12.0,
                              fontWeight: pw.FontWeight.bold,
                            )),
                        pw.Text("Curr Reading: ${model.currentMeterReading}",
                            style: pw.TextStyle(
                              fontSize: 12.0,
                              fontWeight: pw.FontWeight.bold,
                            )),
                        pw.Text("Consumed Units: ${model.consumedUnit}",
                            style: pw.TextStyle(
                              fontSize: 12.0,
                              fontWeight: pw.FontWeight.bold,
                            )),
                      ])),
              pw.SizedBox(height: 10.0),
              //BILL HEADING
              pw.Container(
                padding: pw.EdgeInsets.all(10.0),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      //BILL HEADINGS
                      pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("Expenses",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: pw.FontWeight.bold,
                                )),
                            pw.Text("\tUnit",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: pw.FontWeight.bold,
                                )),
                            pw.Text("Rate",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: pw.FontWeight.bold,
                                )),
                            pw.Text("Amount",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: pw.FontWeight.bold,
                                )),
                          ]),
                      pw.Divider(thickness: 0.5),
                      //MONTHLY RENT
                      pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("Monthly Rent",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text(" ",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text(" ",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text("Rs. ${model.rent}",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                          ]),
                      pw.SizedBox(height: 8.0),
                      //ELECTRICITY CHARGE
                      pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("Electric Charge",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text(model.consumedUnit.toString(),
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text("Rs.${model.electricityPerUnitCharge}",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text("Rs. ${model.totalElectricityCost}",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                          ]),
                      //WATER CHARGE
                      pw.SizedBox(height: 8.0),
                      pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("Water Charge.",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text(" ",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text(" ",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text("Rs. ${model.waterCharge}",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                          ]),
                      //INTERNET CHARGE
                      pw.SizedBox(height: 8.0),
                      pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("Internet Charge",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text(" ",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text(" ",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text("Rs. ${model.internetCharge}",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                          ]),
                      //Previous Due
                      pw.SizedBox(height: 8.0),
                      pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("Previous Dues",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text(" ",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text(" ",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text("Rs. ${model.remainingDues}",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                          ]),
                      pw.Divider(thickness: 0.5),
                      //TOTAL
                      pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("Total",
                                style: pw.TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: pw.FontWeight.bold)),
                            pw.Text(" ",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text(" ",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                            pw.Text("Rs. ${model.total}",
                                style: pw.TextStyle(
                                  fontSize: 12.0,
                                )),
                          ]),
                    ]),
              ),
              //BILL CONTENTS
              pw.SizedBox(height: 10.0),
              pw.Align(
                alignment: pw.Alignment.bottomRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Bill From",
                      style: pw.TextStyle(
                          fontSize: 12.0, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text(
                      "${model.ownerEmail}",
                      style: pw.TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ]));
      },
    ));
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future savePdf() async {
    Directory? documentDirectory = await getExternalStorageDirectory();
    randomFileName = getRandomString(10);

    String documentPath = documentDirectory!.path;

    File file = File("$documentPath/$randomFileName");
    file.writeAsBytesSync(List.from(await pdf.save()));

    await Storage(listingNo: listingNo)
        .uploadPDF(file, randomFileName)
        .then((value) async {
      print('File Uploaded');
      pdfURL =
          await Storage(listingNo: listingNo).downloadPDFURL(randomFileName);
    });
  }

  void setBillData() async {
    final pref = await SharedPreferences.getInstance();
    Timestamp time = Timestamp.fromDate(DateTime.now());

    var model = Billings(
      ownerEmail: pref.getString("email"),
      month: billMonthDropdownValue,
      remainingDues: dueRemaining,
      electricityPerUnitCharge: perUnitElectricityCharge,
      lastMeterReading: lastMeterReading,
      currentMeterReading: int.parse(currentMeterReadingController.text),
      rent: rentCharge,
      consumedUnit: consumedUnit,
      totalElectricityCost: electricityCost,
      waterCharge: waterCharge,
      total: total,
      tenantEmail: tenantDropdownValue,
      status: "Pending",
      pdfLink: "",
      internetCharge: internetCharge,
      billDate: time,
    );

    writeOnPdf(model);
    await savePdf().then((value) => null).catchError((e) => print(e));

    var query = _fireStore.collection('Billings').get();
    await query.then((value) {
      Map<String, dynamic> addBill = {};
      if (value.docs.isEmpty) {
        addBill = addData(model);
      } else {
        addBill = addData(model);
      }
      _fireStore.collection('Billings').add(addBill).then((value) async {
        print("Data Updated");

        var query = _fireStore
            .collection('Billings')
            .where("OwnerEmail", isEqualTo: model.ownerEmail)
            .where("TenantEmail", isEqualTo: model.tenantEmail)
            .where("Month", isEqualTo: model.month)
            .where("LastMeterReading", isEqualTo: model.lastMeterReading)
            .where("CurrentMeterReading", isEqualTo: model.currentMeterReading)
            .get();
        await query.then((value) {
          if (value.docs.isNotEmpty) {
            for (var doc in value.docs) {
              // userList.add(User.fromFireStoreSnapshot(doc));
              document = Billings.fromFireStoreSnapshot(doc);
            }
          }
        });

        await _fireStore
            .collection('Billings')
            .doc(document.documentId)
            .update({"PDFLink": pdfURL}).then((value) {
          print(pdfURL.toString());
          notificationQuery();
        }).catchError(
          (error) => print("Failed to add data: $error"),
        );
      }).catchError((error) {
        print("Failed to add data: $error");
      });
    });
  }

  Map<String, dynamic> addData(Billings model) {
    Map<String, dynamic> data = <String, dynamic>{
      'OwnerEmail': model.ownerEmail,
      'Month': model.month,
      'RemainingDues': model.remainingDues,
      'ElectricityPerUnitCharge': model.electricityPerUnitCharge,
      'LastMeterReading': model.lastMeterReading,
      'CurrentMeterReading': model.currentMeterReading,
      'Rent': model.rent,
      'ConsumedUnit': model.consumedUnit,
      'TenantEmail': model.tenantEmail,
      'TotalElectricityCost': model.totalElectricityCost,
      'WaterCharge': model.waterCharge,
      'TotalCost': model.total,
      'Status': model.status,
      'PDFLink': model.pdfLink,
      'InternetCharge': model.internetCharge,
      'BillDate': model.billDate,
    };
    return data;
  }

  notificationQuery() async {
    final pref = await SharedPreferences.getInstance();
    Timestamp time = Timestamp.fromDate(DateTime.now());

    String bodyMsg = "Your total rent is Rs. $total";
    String titleMsg = "Bill issued for $billMonthDropdownValue";

    var notificationModel = Notifications(
      from: pref.getString("email"),
      to: tenantDropdownValue,
      title: titleMsg,
      body: bodyMsg,
      time: time,
      status: "Pending",
      month: billMonthDropdownValue,
    );

    var query1 = _fireStore.collection('Notifications').get();
    await query1.then((value) {
      Map<String, dynamic> addNotification = {};
      if (value.docs.isEmpty) {
        addNotification = addNotificationData(notificationModel);
      } else {
        addNotification = addNotificationData(notificationModel);
        // }
      }
      _fireStore
          .collection('Notifications')
          .add(addNotification)
          .then((value) async {
        print("Notification Data Updated");
        setState(() {
          isLoading = false;
        });
        Navigator.pop(context);
      }).catchError((error) {
        print("Failed to add data: $error");
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  Map<String, dynamic> addNotificationData(Notifications model) {
    Map<String, dynamic> data = <String, dynamic>{
      'From': model.from,
      'To': model.to,
      'Title': model.title,
      'Body': model.body,
      'Time': model.time,
      'Status': model.status,
      'Month': model.month,
    };
    return data;
  }
}
