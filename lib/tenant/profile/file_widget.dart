import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/billing/pdfView.dart';
import 'package:gharbeti_ui/owner/listings/entity/user_container.dart';

class FileWidget extends StatelessWidget {
  final int index;
  final double width;
  final double height;
  final User data;
  final Function(int index) onTap;

  const FileWidget({
    Key? key,
    required this.index,
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
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: const Color(0xffDCE0F1),
        ),
        child: Row(
          children: [
            Icon(
              Icons.file_copy_outlined,
              color: Color(0xff09548C),
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(data.fileName.toString()),
          ],
        ),
      ),
    );
  }
}
