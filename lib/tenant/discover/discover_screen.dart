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
  List<Room> roomList = [];
  int roomCount = 0;
  bool isLoading = true;
  String address = '';

  final TextEditingController priceController = TextEditingController();
  String priceDropdownValue = 'Below';
  String typeDropdownValue = 'Flat';
  String parkingDropdownValue = 'No';
  String internetDropdownValue = 'No';
  String kitchenDropdownValue = 'No';
  String prefferedDropdownValue = 'Family';
  Filter data = Filter();

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
              showBottomFilter();
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
            RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  isLoading = true;
                });
                setData();
              },
              child: SingleChildScrollView(
                  child: ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: roomCount,
                separatorBuilder: (BuildContext context, int index) => const Divider(
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
            Visibility(visible: isLoading, child: const CustomProgressIndicatorWidget())
          ],
        ),
      ),
    );
  }

  showBottomFilter() {
    return showModalBottomSheet(
        enableDrag: false,
        elevation: 0.0,
        isScrollControlled: false,
        context: context,
        builder: (BuildContext context) {
          width = SizeConfig.safeBlockHorizontal!;
          height = SizeConfig.safeBlockVertical!;
          return Container(
            height: height * 50,
            color: Colors.grey[200],
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Apply Following Filter
                  Container(
                    width: double.infinity,
                    height: height * 5,
                    color: ColorData.primaryColor,
                    child: const Center(
                      child: Text(
                        'Apply Following Filter',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  //Price
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Price'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DropdownButton<String>(
                              underline: Container(
                                height: 0,
                              ),
                              value: priceDropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  priceDropdownValue = newValue!;
                                });
                              },
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              items: <String>[
                                'Above',
                                'Below',
                              ].map<DropdownMenuItem<String>>((String value) {
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
                                keyboardType: TextInputType.number,
                                controller: priceController,
                                cursorColor: const Color(0xff09548c),
                                decoration: const InputDecoration(
                                  hintText: "Enter Here",
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
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
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          icon: const Icon(Icons.arrow_drop_down_sharp),
                          items: <String>['Room', 'Flat', 'House']
                              .map<DropdownMenuItem<String>>((String value) {
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
                          icon: const Icon(Icons.arrow_drop_down_sharp),
                          items: <String>[
                            'No',
                            'Yes',
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
                            'No',
                            'Yes',
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
                  //Preferred
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                          value: prefferedDropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              prefferedDropdownValue = newValue!;
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
                  //End
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          //Cancel Code Here
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ColorData.occupiedColor,
                          ),
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                      InkWell(
                        onTap: () {
                          //Apply Code Here
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ColorData.primaryColor,
                          ),
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                  )
                ],
              ),
            ),
          );
        });
  }
}
