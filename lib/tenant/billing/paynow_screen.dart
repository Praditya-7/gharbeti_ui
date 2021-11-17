import 'package:flutter/material.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';

class PayNow extends StatefulWidget {
  const PayNow({Key? key}) : super(key: key);

  @override
  _PayNowState createState() => _PayNowState();
}

class _PayNowState extends State<PayNow> {
  int billAmount = 8000;
  String owner = "Owner";
  String paymentStatus = "overdue";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F4F4),
      appBar: AppBar(
        title: Text('Payment Details'),
        backgroundColor: ColorData.primaryColor,
      ),
      body: Column(
        children: [
          //Total Payment Info
          Container(
            height: 200,
            padding: EdgeInsets.all(10.0),
            color: ColorData.primaryColor,
            child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Text(
                    "Total Amount to be Paid",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Rs. " + billAmount.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0),
                  ),
                ])),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0)),
              width: double.infinity,
              margin: EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BuildText(
                      text: "Payment To",
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BuildText(
                      text: owner,
                      color: Colors.orange,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BuildText(
                      text: "Payment Type",
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BuildText(
                      text: paymentStatus,
                      color: paymentStatus == "overdue"
                          ? Colors.orange
                          : Colors.green,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BuildText(
                      text: "Payment Option",
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Image(
                            image: AssetImage("assets/image/esewa.png"),
                            width: 100,
                            height: 100,
                          ),
                          onTap: () {},
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        InkWell(
                          child: Image(
                            image: AssetImage("assets/image/khalti.png"),
                            width: 100,
                            height: 100,
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  // cah in hand
                  InkWell(
                    child: BuildText(
                      text: "CASH IN HAND",
                      fontSize: 18,
                      weight: FontWeight.bold,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: ColorData.primaryColor,
          minimumSize: Size(330, 41),
        ),
        child: Text("Pay Now"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
