import 'package:flutter/material.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';

class PayNow extends StatefulWidget {
  const PayNow({Key? key}) : super(key: key);

  @override
  _PayNowState createState() => _PayNowState();
}

class _PayNowState extends State<PayNow> {
  String _payOption = "";
  int billAmount = 8000;
  String owner = "Ram shrestha";
  String paymentStatus = "overdue";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      appBar: AppBar(
        title: const Text('Payment Details'),
        backgroundColor: ColorData.primaryColor,
      ),
      body: Column(
        children: [
          //Total Payment Info
          show_payment_info(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0)),
              width: double.infinity,
              margin: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const BuildText(
                    text: "Payment To",
                    fontSize: 16,
                  ),
                  BuildText(
                    text: owner,
                    color: Colors.orange,
                    fontSize: 16,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const BuildText(
                    text: "Payment Type",
                    fontSize: 16,
                  ),
                  BuildText(
                    text: paymentStatus,
                    color: paymentStatus == "overdue"
                        ? Colors.orange
                        : Colors.green,
                    fontSize: 16,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const BuildText(
                    text: "Payment Option",
                    fontSize: 16,
                  ),
                  //Payment Options
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Image(
                            image: AssetImage("assets/image/khalti.png"),
                            width: 100,
                            height: 100,
                          ),
                          BuildText(
                            text: "CASH IN HAND",
                            fontSize: 18,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  // cah in hand
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              constraints: BoxConstraints.loose(Size(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * 0.35)),
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0)),
                              color: ColorData.primaryColor,
                            ),
                            padding: const EdgeInsets.all(10.0),
                            width: double.infinity,
                            child: const Center(
                              child: BuildText(
                                text: "Choose the payment option",
                                fontSize: 18,
                                weight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(
                                value: "khalti",
                                groupValue: _payOption,
                                onChanged: (value) {
                                  setState(() {
                                    _payOption = value.toString();
                                  });
                                },
                              ),
                              const Image(
                                image: AssetImage("assets/image/khalti.png"),
                                width: 70,
                                height: 70,
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              const BuildText(
                                text: "Khalti",
                                fontSize: 18,
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(
                                value: "cash",
                                groupValue: _payOption,
                                onChanged: (value) {
                                  setState(() {
                                    _payOption = value.toString();
                                  });
                                },
                              ),
                              Icon(
                                Icons.account_balance_wallet_sharp,
                                color: ColorData.primaryColor,
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              const BuildText(
                                text: "Cash",
                                fontSize: 18,
                                weight: FontWeight.bold,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              print(_payOption);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: ColorData.primaryColor,
                              minimumSize: const Size(300, 41),
                            ),
                            child: const Text("Pay"),
                          ),
                        ],
                      );
                    });
              });
        },
        style: ElevatedButton.styleFrom(
          primary: ColorData.primaryColor,
          minimumSize: Size(330, 41),
        ),
        child: const Text("Pay Now"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //Payment Detail
  Widget show_payment_info() {
    return Container(
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
    );
  }
}
