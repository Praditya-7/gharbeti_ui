import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/billing/entity/billing_container.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class PayNow extends StatefulWidget {
  static String route = '/payNowScreen';
  const PayNow({Key? key}) : super(key: key);

  @override
  _PayNowState createState() => _PayNowState();
}

class _PayNowState extends State<PayNow> {
  Billings args = Billings();
  String _payOption = "";
  int billAmount = 8000;
  String owner = "Ram shrestha";
  String paymentStatus = "overdue";

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)!.settings.arguments as Billings;
    super.didChangeDependencies();
  }

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

          Container(
            height: 200,
            padding: EdgeInsets.all(10.0),
            color: ColorData.primaryColor,
            child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  const Text(
                    "Total Amount to be Paid",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Rs. " + args.total.toString(),
                    style: const TextStyle(
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
                    text: args.ownerEmail.toString(),
                    color: Colors.orange,
                    fontSize: 16,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const BuildText(
                    text: "Bill Month",
                    fontSize: 16,
                  ),
                  BuildText(
                    text: args.month.toString(),
                    color: Colors.orange,
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
              builder: (BuildContext buildContext) {
                return StatefulBuilder(
                    builder: (BuildContext buildContext, StateSetter setState) {
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
                            value: "Cash",
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
                          if (_payOption == "khalti") {
                            final config = PaymentConfig(
                              amount: int.parse(args.total.toString()) * 100,
                              // Amount should be in paisa
                              productIdentity:
                                  'test_public_key_dc74e0fd57cb46cd93832aee0a507256',
                              productName: 'Dell G5 G5510 2021',
                              productUrl: 'https://www.khalti.com/#/bazaar',
                            );
                            KhaltiScope.of(context).pay(
                              config: config,
                              preferences: [
                                PaymentPreference.khalti,
                              ],
                              onSuccess: (value) {},
                              onFailure: (onFailure) {},
                              onCancel: () {},
                            );
                          } else {}
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
}
