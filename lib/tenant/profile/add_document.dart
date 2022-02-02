import 'package:flutter/material.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';

class AddDocuments extends StatefulWidget {
  static String route = '/addDocument';
  const AddDocuments({Key? key}) : super(key: key);

  @override
  _AddDocumentsState createState() => _AddDocumentsState();
}

class _AddDocumentsState extends State<AddDocuments> {
  String? documentTypeDropdownValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My Documents'),
        backgroundColor: ColorData.primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Color(0xff09548c),
          onPressed: () {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                constraints: BoxConstraints.loose(Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height * 0.25)),
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(builder:
                      (BuildContext buildContext, StateSetter setState) {
                    return Column(
                      children: [
                        //Heading
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            color: ColorData.primaryColor,
                          ),
                          width: double.infinity,
                          padding: const EdgeInsets.all(12.0),
                          child: const BuildText(
                            text: "Select the File to Upload",
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //Type
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: const Color(0xffDCE0F1),
                          ),
                          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          padding: EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text('Type*'),
                            underline: Container(
                              height: 0,
                            ),
                            value: documentTypeDropdownValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                documentTypeDropdownValue = newValue!;
                              });
                            },
                            icon: const Icon(Icons.arrow_drop_down_sharp),
                            items: <String>[
                              'Citizenship',
                              'DrivingLicense',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //FileSelectedinfoText
                        const Text("No file Selected"),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange,
                              ),
                              child: const Text("Select"),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                              ),
                              child: const Text("Upload"),
                            ),
                          ],
                        ),
                        //Upload Button
                      ],
                    );
                  });
                });
          }),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              color: ColorData.primaryColor,
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              child: const BuildText(
                text: "Uploaded Files",
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            //FileWidget
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: const Color(0xffDCE0F1),
              ),
              child: Row(
                children: const [
                  Icon(
                    Icons.file_copy_outlined,
                    color: Color(0xff09548C),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text('FileName123.pdf'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
