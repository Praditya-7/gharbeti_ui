// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';
import 'package:gharbeti_ui/owner/home/room_widget.dart';
import 'package:gharbeti_ui/owner/listings/screens/add_listings_screen.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/progress_indicator_widget.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class OwnerHomeScreen extends StatefulWidget {
  static String route = '/ownerHomeScreen';

  const OwnerHomeScreen({Key? key}) : super(key: key);

  @override
  State<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
  int roomCount = 0;
  int vacantCount = 0;
  TabController? controller;
  int occupiedCount = 0;
  double width = 0.0;
  double height = 0.0;
  List<Room> roomList = [];
  List<Room> vacantList = [];
  List<Room> occupiedList = [];
  bool isLoading = true;

  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() async {
    roomList.clear();
    final pref = await SharedPreferences.getInstance();
    var email = pref.getString("email");
    var query = _fireStore
        .collection('Room')
        .where("OwnerEmail", isEqualTo: email)
        .get();
    await query.then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          roomList.add(Room.fromFireStoreSnapshot(doc));
        }
      }
    });
    vacantList.clear();
    occupiedList.clear();

    for (var item in roomList) {
      if (item.status == "vacant") {
        vacantList.add(item);
      } else {
        occupiedList.add(item);
      }
    }
    setState(() {
      roomCount = roomList.length;
      vacantCount = vacantList.length;
      occupiedCount = occupiedList.length;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal!;
    height = SizeConfig.safeBlockVertical!;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(240, 240, 240, 1),
        body: Container(
          color: Color.fromRGBO(240, 240, 240, 1),
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
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _getRoomInfo(),
                        SizedBox(height: 20),
                        Expanded(
                          child: roomCount != 0
                              ? _getVacantOccupiedTab()
                              : _getNoRoomWidget("No Rooms available"),
                        ),
                        SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                  visible: isLoading, child: CustomProgressIndicatorWidget())
            ],
          ),
        ),
      ),
    );
  }

  Widget _getVacantOccupiedTab() {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              labelColor: Colors.black,
              controller: controller,
              isScrollable: false,
              tabs: [
                Tab(
                  text: "Vacant",
                ),
                Tab(
                  text: "Occupied",
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(controller: controller, children: <Widget>[
              _createVacantList(),
              _createOccupiedList(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _createVacantList() {
    return vacantList.isNotEmpty
        ? ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding: index == 0
                  ? const EdgeInsets.only(top: 20.0)
                  : const EdgeInsets.all(0),
              child: RoomWidget(
                index: index,
                onTap: (index) {
                  //room Detail
                },
                data: vacantList[index],
                width: width,
                height: height,
              ),
            ),
            itemCount: vacantList.length,
          )
        : Padding(
            padding: const EdgeInsets.only(top: 10),
            child: _getNoRoomWidget("No vacant rooms available"),
          );
  }

  Widget _createOccupiedList() {
    return occupiedList.isNotEmpty
        ? ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding: index == 0
                  ? const EdgeInsets.only(top: 20.0)
                  : const EdgeInsets.all(0),
              child: RoomWidget(
                index: index,
                data: occupiedList[index],
                onTap: (index) {
                  //room detail
                },
                width: width,
                height: height,
              ),
            ),
            itemCount: occupiedList.length,
          )
        : Padding(
            padding: const EdgeInsets.only(top: 10),
            child: _getNoRoomWidget("No occupied rooms available"),
          );
  }

  Widget _getNoRoomWidget(String title) {
    return Container(
      height: width * 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
          child: BuildText(
        text: title,
        fontSize: 20,
      )),
    );
  }

  Widget _getRoomInfo() {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildText(
            text: "Room Info",
            fontSize: 16.0,
            weight: FontWeight.w800,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _getAddWidget(),
              Container(
                padding: const EdgeInsets.only(right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _getRoomStatus(ColorData.vacantColor,
                        vacantCount.toString(), "Vacant"),
                    SizedBox(height: 20),
                    _getRoomStatus(ColorData.occupiedColor,
                        occupiedCount.toString(), "Occupied"),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _getAddWidget() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AddListingsScreen.route);
      },
      child: Container(
        width: width * 40,
        height: width * 40,
        decoration: BoxDecoration(
          color: ColorData.roundColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: BuildText(
            text: roomCount != 0 ? "$roomCount Room" : "+add",
            fontSize: 24,
            weight: roomCount != 0 ? FontWeight.w500 : FontWeight.w700,
            color: roomCount != 0 ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _getRoomStatus(Color color, String data, String title) {
    return Row(
      children: [
        Container(
          width: width * 6,
          height: width * 10,
          padding: const EdgeInsets.only(top: 5, bottom: 5, right: 2, left: 2),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Center(
            child: BuildText(
              text: data,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 10),
        BuildText(
          text: title,
          fontSize: 18,
        )
      ],
    );
  }
}
