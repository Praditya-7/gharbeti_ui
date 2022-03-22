import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/listings/entity/user_container.dart';
import 'package:gharbeti_ui/owner/listings/service/storage_service.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/progress_indicator_widget.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';
import 'package:gharbeti_ui/tenant/profile/file_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class AddDocuments extends StatefulWidget {
  static String route = '/addDocument';
  const AddDocuments({Key? key}) : super(key: key);

  @override
  _AddDocumentsState createState() => _AddDocumentsState();
}

class _AddDocumentsState extends State<AddDocuments> {
  User document = User();
  List<User> userList = [];
  String? documentTypeDropdownValue;
  String randomFileName = '';
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();
  bool pdfSelected = false;
  List<String?> files = [];
  String pdfLink = '';
  List<String> pdfDownloadLink = [];
  bool addDocumentSelected = false;
  bool isFileUploaded = false;
  int userCount = 0;

  double width = 0.0;
  double height = 0.0;

  bool isLoading = true;

  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() async {
    final pref = await SharedPreferences.getInstance();
    var email = pref.getString("email");
    var query =
        _fireStore.collection('Users').where("Email", isEqualTo: email).get();
    await query.then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          userList.add(User.fromFireStoreSnapshot(doc));
        }
      }
    });
    setState(() {
      if (userList[0].pdfLink.toString() == "") {
        isFileUploaded = false;
      } else {
        isFileUploaded = true;
      }
      userCount = userList.length;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal!;
    height = SizeConfig.safeBlockVertical!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Documents'),
        backgroundColor: ColorData.primaryColor,
      ),
      floatingActionButton: isFileUploaded == false
          ? FloatingActionButton(
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: const Color(0xff09548c),
              onPressed: () {
                setState(() {
                  addDocumentSelected = !addDocumentSelected;
                });
              })
          : null,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  addDocumentSelected == true
                      ? Column(
                          children: [
                            //Heading
                            Container(
                              decoration: BoxDecoration(
                                color: ColorData.primaryColor,
                              ),
                              width: double.infinity,
                              padding: const EdgeInsets.all(12.0),
                              child: const BuildText(
                                text: "Select the File to Upload (pdf)",
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
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
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
                            pdfSelected == false
                                ? const Text(
                                    'No File selected (Only pdf allowed)')
                                : const Text('File selected'),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: ['pdf'],
                                    );
                                    if (result != null) {
                                      files = result.paths;
                                      print(files);
                                      setState(() {
                                        pdfSelected = true;
                                      });
                                    } else {
                                      setState(() {
                                        pdfSelected = false;
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.orange,
                                  ),
                                  child: const Text("Select"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    uploadData();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                  ),
                                  child: const Text("Upload"),
                                ),
                              ],
                            ),
                            //Upload Button
                          ],
                        )
                      : Container(),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: ColorData.primaryColor,
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    child: const BuildText(
                      text: "Uploaded Files",
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  //FileWidget
                  SingleChildScrollView(
                    child: isFileUploaded == false
                        ? const Text('No Document Found')
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: userCount,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(
                              height: 0.1,
                              indent: 0,
                              thickness: 0.1,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return FileWidget(
                                height: height,
                                width: width,
                                data: userList[index],
                                onTap: (index) {
                                  //ROUTE CODE HERE
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isLoading,
              child: const CustomProgressIndicatorWidget(),
            ),
          ],
        ),
      ),
    );
  }

  uploadData() async {
    randomFileName = getRandomString(10);
    final pref = await SharedPreferences.getInstance();
    var email = pref.getString("email");
    String fileName = documentTypeDropdownValue.toString() + randomFileName;

    for (int i = 0; i < files.length; i++) {
      String? pdfFilePath = files[i].toString();
      await Storage(listingNo: '')
          .uploadDocument(pdfFilePath, fileName)
          .then((value) async {
        print('Uploaded');
        pdfLink = await Storage(listingNo: '').downloadDocumentLink(fileName);
        var query = _fireStore
            .collection('Users')
            .where("Email", isEqualTo: email)
            .get();
        await query.then((value) {
          if (value.docs.isNotEmpty) {
            for (var doc in value.docs) {
              document = User.fromFireStoreSnapshot(doc);
            }
          }
        }).catchError(
          (error) => print("Failed to get DocumentID: $error"),
        );
        await _fireStore.collection('Users').doc(document.documentId).update({
          "PDFLink": pdfLink.toString(),
          "FileName": fileName.toString(),
        }).then((value) {
          print("ADDED TO USERS");
        }).catchError(
          (error) => print("Failed to UPDATE: $error"),
        );
      }).catchError(
        (error) => print("Failed to Upload: $error"),
      );
    }
    //
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
