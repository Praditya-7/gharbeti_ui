import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:gharbeti_ui/shared/color.dart';

class ViewPdfBill extends StatefulWidget {
  static String route = '/viewPdfBill';

  const ViewPdfBill({
    Key? key,
  }) : super(key: key);

  @override
  State<ViewPdfBill> createState() => _ViewPdfBillState();
}

class _ViewPdfBillState extends State<ViewPdfBill> {
  String args = '';
  bool isloading = true;
  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)!.settings.arguments as String;
    print(args.toString());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bill Pdf View"),
        backgroundColor: ColorData.primaryColor,
      ),
      body: SafeArea(
        child: PDF(
                enableSwipe: true,
                swipeHorizontal: true,
                autoSpacing: true,
                pageFling: true,
                pageSnap: true)
            .cachedFromUrl(
          args.toString(),
          placeholder: (progress) => Center(child: Text('$progress %')),
          errorWidget: (error) => Center(child: Text(error.toString())),
        ),
      ),
    );
  }
}
