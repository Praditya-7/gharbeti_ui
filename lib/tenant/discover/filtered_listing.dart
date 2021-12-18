import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/progress_indicator_widget.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:gharbeti_ui/tenant/discover/discover_widget.dart';
import 'package:gharbeti_ui/tenant/discover/entity/filter_container.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
final FirebaseStorage _storage = FirebaseStorage.instance;

class FilteredListing extends StatefulWidget {
  static String route = '/discoverFiltered';

  const FilteredListing({Key? key}) : super(key: key);

  @override
  _FilteredListingState createState() => _FilteredListingState();
}

class _FilteredListingState extends State<FilteredListing> {
  double width = 0.0;
  double height = 0.0;
  List<Room> roomList = [];
  List<Room> filteredRoomList = [];
  int roomCount = 0;
  bool isLoading = true;
  String address = '';
  Filter args = Filter();

  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() async {
    roomList.clear();

    Future.delayed(Duration.zero, () {
      setState(() {
        args = ModalRoute.of(context)!.settings.arguments as Filter;
      });
    });
    print(args.priceDropdown.toString());

    var query = _fireStore.collection('Rooms').where("Type", isEqualTo: "Flat").get();
    await query.then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          roomList.add(Room.fromFireStoreSnapshot(doc));
        }
      }
    }).catchError((e) {
      print(e);
    });
    print("2------------------");

    // for (var item in roomList) {
    //   if (item.type == data.type) {
    //     if (item.parking == data.parking) {
    //       if (item.internet == data.internet) {
    //         if (item.kitchen == data.kitchen) {
    //           if (item.preferences == data.preferred) {
    //             filteredRoomList.add(item);
    //           }
    //         }
    //       }
    //     }
    //   }
    // }

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
      backgroundColor: Colors.grey,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Result"),
        backgroundColor: ColorData.primaryColor,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
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
            Visibility(visible: isLoading, child: const CustomProgressIndicatorWidget())
          ],
        ),
      ),
    );
  }
}
