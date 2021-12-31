import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/listings/entity/Rooms.dart';
import 'package:gharbeti_ui/owner/listings/service/storage_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class AddListingsScreen extends StatefulWidget {
  static String route = '/addListingScreen';

  const AddListingsScreen({Key? key}) : super(key: key);

  @override
  _AddListingsScreenState createState() => _AddListingsScreenState();
}

class _AddListingsScreenState extends State<AddListingsScreen> {
  String randomFileName = '';
  final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();
  var img;
  var path;
  var fileName;
  bool imageSelected = false;
  List<String?> files = [];
  List<String> imageFileName = [];
  String imageLink = '';
  List<String> imageDownloadLinkList = [];

  Set<Marker> _marker = <Marker>{};
  bool isLoading = false;
  bool showMap = false;
  String? listingTypeDropdownValue;
  String? floorDropdownValue;
  String parkingDropdownValue = 'No';
  String bathroomDropdownValue = '1';
  String kitchenDropdownValue = 'Yes';
  String internetDropdownValue = 'Yes';
  String negotiableDropdownValue = 'Yes';
  String preferencesDropdownValue = 'Family';

  late LatLng _latLng;

  late GoogleMapController _googleMapController;
  final TextEditingController _listingNo = TextEditingController();
  final TextEditingController lastMeterReadingController = TextEditingController();
  final TextEditingController _additionalDescription = TextEditingController();
  final TextEditingController _price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      appBar: AppBar(
        backgroundColor: const Color(0xff09548c),
        title: const Text('Add Listings'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.message),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //General Information
                const Text(
                  'General Information',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                //GENERAL INFORMATION START
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //TYPE*//
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: const Text('Type*'),
                          underline: Container(
                            height: 0,
                          ),
                          value: listingTypeDropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              listingTypeDropdownValue = newValue!;
                            });
                          },
                          icon: const Icon(Icons.arrow_drop_down_sharp),
                          items: <String>[
                            'Flat',
                            'Room',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      //Listing No//
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: TextField(
                          controller: _listingNo,
                          cursorColor: const Color(0xff09548c),
                          decoration: const InputDecoration(
                            hintText: "Listing No*",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: const Text('Floor*'),
                          underline: Container(
                            height: 0,
                          ),
                          value: floorDropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              floorDropdownValue = newValue!;
                            });
                          },
                          icon: const Icon(Icons.arrow_drop_down_sharp),
                          items: <String>[
                            'Ground',
                            'First',
                            'Second',
                            'Third',
                            'Fourth',
                            'Fifth',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ), //End of General Information//FIRST COLUMN GENERAL INFORMATION END
                //Basic Amenities
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Basic Amenities',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      //Parking
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Parking'),
                            DropdownButton<String>(
                              underline: Container(
                                height: 0,
                              ),
                              value: parkingDropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  parkingDropdownValue = newValue!;
                                });
                              },
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              items: <String>[
                                'No',
                                'Bike',
                                'Car',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      //Bathroom
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Bathroom'),
                            DropdownButton<String>(
                              underline: Container(
                                height: 0,
                              ),
                              value: bathroomDropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  bathroomDropdownValue = newValue!;
                                });
                              },
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              items: <String>[
                                '1',
                                '2',
                                '3',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      //Kitchen
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Kitchen'),
                            DropdownButton<String>(
                              underline: Container(
                                height: 0,
                              ),
                              value: kitchenDropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  kitchenDropdownValue = newValue!;
                                });
                              },
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              items: <String>[
                                'Yes',
                                'No',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      //Internet
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Internet'),
                            DropdownButton<String>(
                              underline: Container(
                                height: 0,
                              ),
                              value: internetDropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  internetDropdownValue = newValue!;
                                });
                              },
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              items: <String>[
                                'Yes',
                                'No',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //Price(Monthly)
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Rent Price(Monthly)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: TextField(
                          controller: _price,
                          cursorColor: const Color(0xff09548c),
                          decoration: const InputDecoration(
                            hintText: "Rent Price(in Rs.)",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Negotiable'),
                            DropdownButton<String>(
                              underline: Container(
                                height: 0,
                              ),
                              value: negotiableDropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  negotiableDropdownValue = newValue!;
                                });
                              },
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              items: <String>[
                                'Yes',
                                'No',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ), //End of Price(Monthly)
                //Additional Description
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Additional Description',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),

                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        padding: const EdgeInsets.fromLTRB(18, 2, 30, 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Last Meter Reading'),
                            SizedBox(
                              width: 100,
                              child: TextField(
                                textAlign: TextAlign.end,
                                keyboardType: TextInputType.number,
                                controller: lastMeterReadingController,
                                cursorColor: const Color(0xff09548c),
                                decoration: const InputDecoration(
                                  hintText: "Enter Here",
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Preferences'),
                            DropdownButton<String>(
                              underline: Container(
                                height: 0,
                              ),
                              value: preferencesDropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  preferencesDropdownValue = newValue!;
                                });
                              },
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              items: <String>[
                                'Family',
                                'Individual',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: TextField(
                          maxLines: 15,
                          minLines: 5,
                          controller: _additionalDescription,
                          cursorColor: const Color(0xff09548c),
                          decoration: const InputDecoration(
                            hintText: "Additional Description",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ), //End of Additional Description
                //Pin Location
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Pin Listing Location',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        height: 400,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: GoogleMap(
                          compassEnabled: false,
                          mapType: MapType.normal,
                          myLocationEnabled: true,
                          trafficEnabled: false,
                          buildingsEnabled: false,
                          mapToolbarEnabled: false,
                          onMapCreated: (GoogleMapController controller) {
                            _googleMapController = controller;
                          },
                          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                            Factory<OneSequenceGestureRecognizer>(
                              () => EagerGestureRecognizer(),
                            ),
                          },
                          cameraTargetBounds: CameraTargetBounds.unbounded,
                          onTap: (point) {
                            setState(() {
                              _marker = {
                                Marker(
                                  markerId: const MarkerId('Pin'),
                                  icon: BitmapDescriptor.defaultMarker,
                                  position: point,
                                )
                              };
                              _latLng = point;
                            });
                          },
                          myLocationButtonEnabled: true,
                          markers: _marker,
                          initialCameraPosition: const CameraPosition(
                            bearing: 0.0,
                            target: LatLng(27.7172, 85.3240),
                            zoom: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //End of Pin Location
                //Room Photos
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Room Photos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(allowMultiple: true);
                          if (result != null) {
                            files = result.paths;
                            print(files);
                            setState(() {
                              imageSelected = true;
                            });
                          } else {
                            setState(() {
                              imageSelected = false;
                            });
                          }
                        },
                        child: const Center(
                          child: ListTile(
                            leading: Icon(
                              Icons.upload,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Upload Images',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      imageSelected == false
                          ? const Text('No image selected')
                          : const Text('Image selected'),
                    ],
                  ),
                ),
                //End of Room Photos
                const SizedBox(
                  height: 10,
                ),
                //Add
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xff09548c),
                  ),
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                        setData();
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(30, 8, 30, 8),
                      child: Center(
                        child: Text(
                          'Add Listing',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getRandomString(int length) => String.fromCharCodes(
      Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  void setData() async {
    randomFileName = getRandomString(10);
    final pref = await SharedPreferences.getInstance();

    for (int i = 0; i < files.length; i++) {
      randomFileName = getRandomString(10);
      imageFileName.add(randomFileName);
      String? imageFile = files[i].toString();
      await Storage(listingNo: _listingNo.text.toString())
          .uploadImage(imageFile, randomFileName)
          .then((value) async {
        print('Uploaded');
        imageLink =
            await Storage(listingNo: _listingNo.text.toString()).downloadImageURL(randomFileName);
        imageDownloadLinkList.add(imageLink);
      });
    }

    var model = Rooms(
      type: listingTypeDropdownValue,
      listingNo: _listingNo.text.toString(),
      floor: floorDropdownValue,
      parking: parkingDropdownValue,
      bathrooms: bathroomDropdownValue,
      kitchen: kitchenDropdownValue,
      internet: internetDropdownValue,
      rent: _price.text.toString(),
      negotiable: negotiableDropdownValue,
      preferences: preferencesDropdownValue,
      description: _additionalDescription.text.toString(),
      email: pref.getString("email"),
      status: "Vacant",
      lat: _latLng.latitude,
      long: _latLng.longitude,
      lastMeterReading: lastMeterReadingController.text.toString(),
      tenantEmail: "",
      imagesLinkList: imageDownloadLinkList,
    );

    var query = _fireStore.collection('Rooms').get();
    await query.then((value) {
      Map<String, dynamic> addRoom = {};
      if (value.docs.isEmpty) {
        addRoom = addData(model);
      } else {
        addRoom = addData(model);
        // }
      }
      _fireStore.collection('Rooms').add(addRoom).then((value) async {
        print("Data Updated");
        setState(() {
          isLoading = false;
        });
        Navigator.pop(context);
      }).catchError((error) {
        print("Failed to add data: $error");
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  Map<String, dynamic> addData(Rooms model) {
    Map<String, dynamic> data = <String, dynamic>{
      "Type": model.type,
      "ListingNo": model.listingNo,
      "Floor": model.floor,
      "Parking": model.parking,
      "Bathrooms": model.bathrooms,
      "Kitchen": model.kitchen,
      "Internet": model.internet,
      "Rent": model.rent,
      "Negotiable": model.negotiable,
      "Description": model.description,
      "Status": model.status,
      "OwnerEmail": model.email,
      "Preferences": model.preferences,
      "Latitude": model.lat,
      "Longitude": model.long,
      "Tenant Email": model.tenantEmail,
      "LastMeterReading": model.lastMeterReading,
      "ImageLinkList": imageDownloadLinkList,
    };
    return data;
  }
}
