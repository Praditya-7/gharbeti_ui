import 'package:flutter/material.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';

class ListingFilterPage extends StatefulWidget {
  static String route = '/listingFilterPage';
  const ListingFilterPage({Key? key}) : super(key: key);

  @override
  _ListingFilterPageState createState() => _ListingFilterPageState();
}

class _ListingFilterPageState extends State<ListingFilterPage> {
  int price = 0;
  String priceDropdownValue = 'Above';
  String listingTypeDropdownValue = 'Room';
  String parkingDropdownValue = 'Bike';
  String internetDropdownValue = 'Yes';
  String kitchenDropdownValue = 'Yes';
  String prefferedDropdownValue = 'Family';

  final TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      appBar: AppBar(
        title: const Text("Filter Listing"),
        backgroundColor: ColorData.primaryColor,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.check_box,
                  color: Colors.white,
                ),
              )),
        ],
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BuildText(
                text: "Apply following filters",
                fontSize: 16,
                weight: FontWeight.bold,
              ),
              //PRICE
              const SizedBox(
                height: 30,
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
                    const Text('Price(in Rs.)'),
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownButton<String>(
                      menuMaxHeight: 75,
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
                      width: 50,
                      child: TextField(
                        textAlign: TextAlign.end,
                        keyboardType: TextInputType.number,
                        controller: priceController,
                        cursorColor: Color(0xff09548c),
                        onChanged: (value) {
                          setState(() {
                            price = int.parse(priceController.text);
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
                      value: listingTypeDropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          listingTypeDropdownValue = newValue!;
                        });
                      },
                      icon: const Icon(Icons.arrow_drop_down_sharp),
                      items: <String>[
                        'Room',
                        'Flat',
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
              const SizedBox(
                height: 20,
              ),
              //PARKING
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
              const SizedBox(
                height: 20,
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
              const SizedBox(
                height: 20,
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
              const SizedBox(
                height: 20,
              ),
              //Preferences
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
            ],
          ),
        ),
      ),
    );
  }
}
