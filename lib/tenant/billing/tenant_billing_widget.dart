import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/billing/entity/billing_container.dart';
import 'package:gharbeti_ui/owner/billing/pdfView.dart';
import 'package:gharbeti_ui/tenant/billing/paynow_screen.dart';
import 'package:intl/intl.dart';

class TenantBillingWidget extends StatefulWidget {
  final double width;
  final double height;
  final Billings data;

  const TenantBillingWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.data,
  }) : super(key: key);

  @override
  State<TenantBillingWidget> createState() => _TenantBillingWidgetState();
}

class _TenantBillingWidgetState extends State<TenantBillingWidget> {
  @override
  Widget build(BuildContext context) {
    var unformattedDate = widget.data.billDate?.toDate();
    String formattedDate =
        DateFormat.yMMMMd().format(unformattedDate!).toString();
    return Container(
      margin: EdgeInsets.all(10),
      padding: const EdgeInsets.all(10.0),
      color: Colors.white,
      child: Column(
        children: [
          //MonthlyRent Rs and Pdf icon Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total\nRs. ' + widget.data.total.toString(),
                style: const TextStyle(
                  color: Color(0xff09548c),
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                iconSize: 35,
                padding: const EdgeInsets.all(10),
                icon: const Icon(
                  Icons.picture_as_pdf,
                  color: Color(0xff09548c),
                ),
                onPressed: () {
                  String pdfURL = widget.data.pdfLink.toString();
                  Navigator.of(context)
                      .pushNamed(ViewPdfBill.route, arguments: pdfURL);
                },
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          //Rent Month
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Rent of Month',
              ),
              Text(
                "${widget.data.month.toString()}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          //BillIssued Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Bill Date'),
              Text(
                formattedDate,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          //Bill Issued By
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Bill Issued By'),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.data.ownerEmail.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ), //Type of Payment
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          //BillStatus
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Bill Status'),
              Text(
                widget.data.status.toString(),
                style: TextStyle(
                  color: widget.data.status.toString() == "Paid"
                      ? Colors.green
                      : const Color(0xffF6821E),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          //Paynow Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              widget.data.status.toString() == "Pending"
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.deepOrangeAccent,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PayNow()));
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Pay Now',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          )
        ],
      ),
    );
  }
}
