import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/progress_indicator_widget.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:gharbeti_ui/tenant/discover/discover_near_you.dart';
import 'package:gharbeti_ui/tenant/discover/discover_widget.dart';

import 'entity/filter_container.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class DiscoverTenantScreen extends StatefulWidget {
  const DiscoverTenantScreen({Key? key}) : super(key: key);

  @override
  _DiscoverTenantScreenState createState() => _DiscoverTenantScreenState();
}

class _DiscoverTenantScreenState extends State<DiscoverTenantScreen> {
  final TextEditingController _destinationController = TextEditingController();
  double width = 0.0;
  double height = 0.0;
  double blurValue = 0.0;
  List<Room> roomList = [];
  List<Room> filterList = [];
  Filter data = Filter();
  int roomCount = 0;
  bool isLoading = true;
  String address = '';
  bool filterSelected = false;
  bool isIgnored = false;
  bool filterApplied = false;
  bool noDataFound = false;

  final TextEditingController priceController = TextEditingController();
  String priceDropdownValue = 'Below';
  String typeDropdownValue = 'Flat';
  String parkingDropdownValue = 'No';
  String internetDropdownValue = 'No';
  String kitchenDropdownValue = 'No';
  String preferredDropdownValue = 'Family';

  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() async {
    roomList.clear();
    var query = _fireStore.collection('Rooms').get();
    await query.then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          roomList.add(Room.fromFireStoreSnapshot(doc));
        }
      }
    });
    setState(() {
      roomCount = roomList.length;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal!;
    height = SizeConfig.safeBlockVertical!;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          margin: const EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 20),
          padding: const EdgeInsets.only(left: 5, right: 20),
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color(0xffEEEEEE),
          ),
          child: TextField(
            controller: _destinationController,
            cursorColor: const Color(0xff09548c),
            decoration: const InputDecoration(
              focusColor: Color(0xff09548c),
              fillColor: Color.fromRGBO(240, 240, 240, 1),
              filled: true,
              icon: Icon(
                Icons.search,
                color: Color(0xff09548c),
              ),
              hintText: "Search Destination",
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(DiscoverNearYou.route);
            },
            icon: const Icon(
              Icons.location_on_outlined,
              color: Color(0xff09548c),
            ),
          ),
          IconButton(
            onPressed: () {
              // Navigator.of(context).pushNamed(DiscoverFilter.route);
              setState(() {
                isIgnored = true;
                blurValue = 3.0;
                filterSelected = true;
              });
            },
            icon: const Icon(
              CupertinoIcons.slider_horizontal_3,
              color: Color(0xff09548c),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Stack(
              children: [
                //List
                Positioned.fill(
                  child: IgnorePointer(
                    ignoring: isIgnored,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        setState(() {
                          isLoading = true;
                        });
                        setData();
                      },
                      child: noDataFound == true
                          ? const Center(child: Text('No Listing Found'))
                          : SingleChildScrollView(
                              child: ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: roomCount,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(
                                height: 0.1,
                                indent: 0,
                                thickness: 0.1,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return DiscoverWidget(
                                  index: index,
                                  data: roomList[index],
                                  width: width,
                                  height: height,
                                  onTap: (index) {
                                    //Navigate code here
                                  },
                                );
                              },
                            )),
                    ),
                  ),
                ),
                //Filter
                Positioned(
                  left: width * 3,
                  right: width * 3,
                  top: height * 9,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: blurValue,
                      sigmaY: blurValue,
                    ),
                    child: Visibility(
                      visible: filterSelected,
                      child: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //Apply Following Filter
                            Container(
                              decoration: BoxDecoration(
                                // border: Border.all(color: Colors.black26),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                ),
                                color: ColorData.primaryColor,
                              ),
                              width: double.infinity,
                              height: height * 4,
                              child: const Center(
                                child: Text(
                                  'Apply Following Filter',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ColorData.primaryColor,
                                ),
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  //Price
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      // color: Colors.grey[200],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Price'),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            DropdownButton<String>(
                                              underline: Container(
                                                height: 0,
                                              ),
                                              value: priceDropdownValue,
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  priceDropdownValue =
                                                      newValue!;
                                                });
                                              },
                                              icon: const Icon(
                                                  Icons.arrow_drop_down_sharp),
                                              items: <String>[
                                                'Above',
                                                'Below',
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: TextField(
                                                textAlign: TextAlign.end,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: priceController,
                                                cursorColor:
                                                    const Color(0xff09548c),
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: "Enter Here",
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  //Type
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      // color: Colors.grey[200],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Type'),
                                        DropdownButton<String>(
                                          underline: Container(
                                            height: 0,
                                          ),
                                          value: typeDropdownValue,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              typeDropdownValue = newValue!;
                                            });
                                          },
                                          icon: const Icon(
                                              Icons.arrow_drop_down_sharp),
                                          items: <String>[
                                            'Room',
                                            'Flat',
                                            'House'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //Parking
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      // color: Colors.grey[200],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                          icon: const Icon(
                                              Icons.arrow_drop_down_sharp),
                                          items: <String>[
                                            'No',
                                            'Bike',
                                            'Car',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
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
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      // color: Colors.grey[200],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Internet',
                                        ),
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
                                          icon: const Icon(
                                              Icons.arrow_drop_down_sharp),
                                          items: <String>[
                                            'No',
                                            'Yes',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
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
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      // color: Colors.grey[200],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                          icon: const Icon(
                                              Icons.arrow_drop_down_sharp),
                                          items: <String>[
                                            'No',
                                            'Yes',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //Preferred
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      // color: Colors.grey[200],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Preferences'),
                                        DropdownButton<String>(
                                          underline: Container(
                                            height: 0,
                                          ),
                                          value: preferredDropdownValue,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              preferredDropdownValue =
                                                  newValue!;
                                            });
                                          },
                                          icon: const Icon(
                                              Icons.arrow_drop_down_sharp),
                                          items: <String>[
                                            'Family',
                                            'Individual',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //End
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      //Cancel
                                      InkWell(
                                        onTap: () {
                                          //Cancel Code Here
                                          setState(() {
                                            filterSelected = false;
                                            isIgnored = false;
                                            blurValue = 0.0;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: ColorData.occupiedColor,
                                          ),
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          child: const Center(
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      //Reset
                                      filterApplied == true
                                          ? InkWell(
                                              onTap: () {
                                                //Cancel Code Here
                                                setState(() {
                                                  filterSelected = false;
                                                  isIgnored = false;
                                                  blurValue = 0.0;
                                                  filterApplied = false;
                                                  noDataFound = false;
                                                  setData();
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black38),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                margin:
                                                    const EdgeInsets.all(10),
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 10, 20, 10),
                                                child: const Center(
                                                  child: Text(
                                                    'Reset',
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(),

                                      //Apply
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            isLoading = true;
                                            setFilterData();
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: ColorData.primaryColor,
                                          ),
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          child: const Center(
                                            child: Text(
                                              'Apply',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
                visible: isLoading,
                child: const CustomProgressIndicatorWidget()),
          ],
        ),
      ),
    );
  }

  setFilterData() async {
    roomList.clear();
    print(data.type);
    var query = _fireStore
        .collection('Rooms')
        .where("Type", isEqualTo: typeDropdownValue.toString())
        .where("Parking", isEqualTo: parkingDropdownValue.toString())
        .where("Internet", isEqualTo: internetDropdownValue.toString())
        .where("Kitchen", isEqualTo: kitchenDropdownValue.toString())
        .where("Preferences", isEqualTo: preferredDropdownValue.toString())
        .get();
    await query.then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          roomList.add(Room.fromFireStoreSnapshot(doc));
        }
      }
    });

    setState(() {
      if (roomList.isEmpty) {
        //NO DATA FOUND
        noDataFound = true;
      }
      filterSelected = false;
      roomCount = roomList.length;
      isIgnored = false;
      isLoading = false;
      blurValue = 0.0;
      filterApplied = true;
    });
  }
}
