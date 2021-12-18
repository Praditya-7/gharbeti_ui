import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:gharbeti_ui/tenant/discover/entity/filter_container.dart';
import 'package:gharbeti_ui/tenant/discover/filtered_listing.dart';

class DiscoverFilter extends StatefulWidget {
  static String route = '/discoverFilter';
  const DiscoverFilter({Key? key}) : super(key: key);

  @override
  _DiscoverFilterState createState() => _DiscoverFilterState();
}

class _DiscoverFilterState extends State<DiscoverFilter> {
  double width = 0.0;
  double height = 0.0;
  String priceDropdownValue = 'Below';
  String typeDropdownValue = 'Flat';
  String parkingDropdownValue = 'No';
  String internetDropdownValue = 'No';
  String kitchenDropdownValue = 'No';
  String prefferedDropdownValue = 'Family';
  Filter data = Filter();
  List<Room> roomList = [];

  final TextEditingController priceController = TextEditingController();

  setData() async {
    data.priceDropdown = priceDropdownValue.toString();
    data.price = priceController.text;
    data.type = typeDropdownValue;
    data.parking = parkingDropdownValue;
    data.internet = internetDropdownValue;
    data.kitchen = kitchenDropdownValue;
    data.preferred = prefferedDropdownValue;
  }

  @override
  Widget build(BuildContext context) {
    width = SizeConfig.safeBlockHorizontal!;
    height = SizeConfig.safeBlockVertical!;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text("Filter"),
          backgroundColor: ColorData.primaryColor,
          actions: <Widget>[
            InkWell(
              onTap: () {
                if (priceController.text == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Enter price!'),
                    ),
                  );
                } else {
                  setData();

                  //Route with argument
                  Navigator.of(context)
                      .pushReplacementNamed(FilteredListing.route, arguments: data);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: ColorData.occupiedColor,
                ),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: const Center(
                  child: Text('Apply'),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
        body: Container(
          height: height * 50,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //Price
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
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
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
              //Internet
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
            ],
          ),
        ),
      ),
    );
  }
}
