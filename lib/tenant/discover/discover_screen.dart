import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';
import 'package:gharbeti_ui/shared/progress_indicator_widget.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:gharbeti_ui/tenant/discover/discover_filter.dart';
import 'package:gharbeti_ui/tenant/discover/discover_near_you.dart';
import 'package:gharbeti_ui/tenant/discover/discover_widget.dart';

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
              Navigator.of(context).pushNamed(DiscoverFilter.route);
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
}
