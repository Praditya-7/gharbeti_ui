import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/progress_indicator_widget.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:gharbeti_ui/tenant/discover/discover_near_you.dart';
import 'package:gharbeti_ui/tenant/discover/discover_widget.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class DiscoverTenantScreen extends StatefulWidget {
  const DiscoverTenantScreen({Key? key}) : super(key: key);

  @override
  _DiscoverTenantScreenState createState() => _DiscoverTenantScreenState();
}

class _DiscoverTenantScreenState extends State<DiscoverTenantScreen> {
  int price = 0;
  String priceDropdownValue = 'Above';
  String listingTypeDropdownValue = 'Room';
  String parkingDropdownValue = 'Bike';
  String internetDropdownValue = 'Yes';
  String kitchenDropdownValue = 'Yes';
  String prefferedDropdownValue = 'Family';
  final TextEditingController priceController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  double width = 0.0;
  double height = 0.0;
  List<Room> roomList = [];
  int roomCount = 0;
  bool isLoading = true;
  String address = '';

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
              //Navigator.of(context).pushNamed(DiscoverFilter.route);
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorData.primaryColor,
                            ),
                            padding: EdgeInsets.all(10.0),
                            width: double.infinity,
                            height: 60.0,
                            child: const Center(
                              child: Text(
                                "Apply following filters",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //PRICE
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 15),
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey[200],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Price(in Rs.)'),
                                      const SizedBox(
                                        width: 10,
                                      ),
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
                                        width: 50,
                                        child: TextField(
                                          textAlign: TextAlign.end,
                                          keyboardType: TextInputType.number,
                                          controller: priceController,
                                          cursorColor: Color(0xff09548c),
                                          onChanged: (value) {
                                            setState(() {
                                              price = int.parse(
                                                  priceController.text);
                                            });
                                          },
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
                                const SizedBox(
                                  height: 20,
                                ),
                                //LISTING TYPE
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 15),
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey[200],
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
                                        value: listingTypeDropdownValue,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            listingTypeDropdownValue =
                                                newValue!;
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.arrow_drop_down_sharp),
                                        items: <String>[
                                          'Room',
                                          'Flat',
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
                                const SizedBox(
                                  height: 20,
                                ),
                                //PARKING
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 15),
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey[200],
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
                                const SizedBox(
                                  height: 20,
                                ),
                                //Internet
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 15),
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey[200],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                const SizedBox(
                                  height: 20,
                                ),
                                //Kitchen
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 15),
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey[200],
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
                                const SizedBox(
                                  height: 20,
                                ),
                                //Preferences
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 15),
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey[200],
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
                                        value: prefferedDropdownValue,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            prefferedDropdownValue = newValue!;
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
                                //apply
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: ColorData.primaryColor,
                                  ),
                                  margin: const EdgeInsets.all(10),
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: const Center(
                                    child: Text(
                                      'Apply',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
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
                separatorBuilder: (BuildContext context, int index) =>
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
            Visibility(
                visible: isLoading,
                child: const CustomProgressIndicatorWidget())
          ],
        ),
      ),
    );
  }
}
