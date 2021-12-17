import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/billing/entity/billing_container.dart';
import 'package:gharbeti_ui/owner/billing/pdfView.dart';
import 'package:intl/intl.dart';

class OwnerBillingWidget extends StatefulWidget {
  final double width;
  final double height;
  final Billings data;

  const OwnerBillingWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.data,
  }) : super(key: key);

  @override
  State<OwnerBillingWidget> createState() => _OwnerBillingWidgetState();
}

class _OwnerBillingWidgetState extends State<OwnerBillingWidget> {
  @override
  Widget build(BuildContext context) {
    var unformattedDate = widget.data.billDate?.toDate();
    String formattedDate = DateFormat.yMMMMd().format(unformattedDate!).toString();
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 10),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rs. ' + widget.data.rent.toString(),
                style: const TextStyle(
                  color: Color(0xff09548c),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Monthly Rent: ${widget.data.month.toString()}',
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Bill Date'),
              const SizedBox(
                height: 10,
              ),
              const Text('Bill Issued To'),
              const SizedBox(
                height: 10,
              ),
              const Text('Bill Status'),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                iconSize: 35,
                padding: const EdgeInsets.all(10),
                icon: const Icon(
                  Icons.picture_as_pdf,
                  color: Color(0xff09548c),
                ),
                onPressed: () {
                  //
                  //PDF OPENER HERE
                  //
                  String pdfURL = widget.data.pdfLink.toString();
                  Navigator.of(context).pushNamed(ViewPdfBill.route, arguments: pdfURL);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                formattedDate,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.data.tenantEmail.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ), //Type of Payment
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.data.status.toString(),
                style: TextStyle(
                  color: widget.data.status.toString() == "Paid"
                      ? Colors.green
                      : const Color(0xffF6821E),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
