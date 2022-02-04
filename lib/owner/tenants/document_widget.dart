import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/billing/pdf_view.dart';
import 'package:gharbeti_ui/owner/listings/entity/user_container.dart';

class DocumentWidget extends StatelessWidget {
  final double width;
  final double height;
  final User data;
  final Function(int index) onTap;

  const DocumentWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        String pdfURL = data.pdfLink.toString();
        Navigator.of(context).pushNamed(ViewPdfBill.route, arguments: pdfURL);
      },
      child: Container(
        height: height * 8,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: const Color(0xffDCE0F1),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.file_copy_outlined,
                color: Color(0xff09548C),
              ),
              SizedBox(
                width: 15.0,
              ),
              Text(
                data.fileName.toString() + ".pdf",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
