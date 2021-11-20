// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

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
  var img;
  var path;
  var fileName;
  bool imageSelected = false;

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

  final TextEditingController _additionalDescription = TextEditingController();
  final TextEditingController _price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      appBar: AppBar(
        backgroundColor: Color(0xff09548c),
        title: Text('Add Listings'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.message),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //General Information
                Text(
                  'General Information',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                //GENERAL INFORMATION START
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //TYPE*//
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: Text('Type*'),
                          underline: Container(
                            height: 0,
                          ),
                          value: listingTypeDropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              listingTypeDropdownValue = newValue!;
                            });
                          },
                          icon: Icon(Icons.arrow_drop_down_sharp),
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
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: TextField(
                          controller: _listingNo,
                          cursorColor: Color(0xff09548c),
                          decoration: InputDecoration(
                            hintText: "Listing No*",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: Text('Floor*'),
                          underline: Container(
                            height: 0,
                          ),
                          value: floorDropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              floorDropdownValue = newValue!;
                            });
                          },
                          icon: Icon(Icons.arrow_drop_down_sharp),
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
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Basic Amenities',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      //Parking
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Parking'),
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
                              icon: Icon(Icons.arrow_drop_down_sharp),
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
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Bathroom'),
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
                              icon: Icon(Icons.arrow_drop_down_sharp),
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
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Kitchen'),
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
                              icon: Icon(Icons.arrow_drop_down_sharp),
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
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Internet'),
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
                              icon: Icon(Icons.arrow_drop_down_sharp),
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
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Rent Price(Monthly)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: TextField(
                          controller: _price,
                          cursorColor: Color(0xff09548c),
                          decoration: InputDecoration(
                            hintText: "Rent Price(in Rs.)",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Negotiable'),
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
                              icon: Icon(Icons.arrow_drop_down_sharp),
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
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Additional Description',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Preferences'),
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
                              icon: Icon(Icons.arrow_drop_down_sharp),
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
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        child: TextField(
                          maxLines: 15,
                          minLines: 5,
                          controller: _additionalDescription,
                          cursorColor: Color(0xff09548c),
                          decoration: InputDecoration(
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
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Pin Listing Location',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
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
                                  markerId: MarkerId('Pin'),
                                  icon: BitmapDescriptor.defaultMarker,
                                  position: point,
                                )
                              };
                              _latLng = point;
                              print(_latLng.latitude);
                            });
                          },
                          myLocationButtonEnabled: true,
                          markers: _marker,
                          initialCameraPosition: CameraPosition(
                            bearing: 0.0,
                            target: LatLng(
                              27.7172,
                              85.3240,
                            ),
                            zoom: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //End of Pin Location

                //Room Photos
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Room Photos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final results = await FilePicker.platform.pickFiles(
                            allowMultiple: true,
                            type: FileType.custom,
                            allowedExtensions: ['png', 'jpg'],
                          );
                          if (results == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('No image selected.'),
                              ),
                            );
                          }

                          path = results!.files.single.path!;
                          fileName = results.files.single.name;
                          setState(() {
                            imageSelected = true;
                          });
                        },
                        child: Center(
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
                      imageSelected == false ? Text('No image selected') : Image.file(File(path)),
                      //
                      // imageSelected == false
                      //     ? Text('No image selected')
                      //     : GridView.builder(
                      //         padding: EdgeInsets.all(10),
                      //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //           crossAxisCount: 2,
                      //           mainAxisSpacing: 8,
                      //           crossAxisSpacing: 8,
                      //         ),
                      //         itemCount: img.length,
                      //         itemBuilder: (context, int index) {
                      //           return Image.file(File(img[index].path!));
                      //         },
                      //       ),
                    ],
                  ),
                ),
                //End of Room Photos

                SizedBox(
                  height: 10,
                ),

                //Add
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xff09548c),
                  ),
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                        setData();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
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

  void setData() async {
    final pref = await SharedPreferences.getInstance();

    await Storage(listingNo: _listingNo.text.toString())
        .uploadImage(path, fileName)
        .then((value) => print('Uploaded'));

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
      imageName: fileName,
      tenantEmail: "",
    );

    var query = _fireStore.collection('Rooms').get();
    await query.then((value) {
      Map<String, dynamic> addRoom = {};
      if (value.docs.isEmpty) {
        addRoom = addData(model);
      } else {
        // var count = 0;
        // for (int i = 0; i < value.docs.length; i++) {
        //   var listingID = value.docs[i]["ListingNo"];
        //   if (model.listingNo == listingID) {
        //     count += 1;
        //     break;
        //   }
        // }
        // if (count > 0) {
        //   setState(() {
        //     isLoading = false;
        //   });
        //   //show message
        // } else {
        addRoom = addData(model);
        // }
      }
      _fireStore.collection('Rooms').add(addRoom).then((value) {
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
      "ImageName": model.imageName,
      "Tenant Email": model.tenantEmail,
    };
    return data;
  }
}
