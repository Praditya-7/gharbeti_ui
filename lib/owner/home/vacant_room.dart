import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/home/tenant_widget.dart';
import 'package:gharbeti_ui/owner/listings/entity/user_container.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/progress_indicator_widget.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';

import 'entity/room_container.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class VacantRoom extends StatefulWidget {
  static String route = '/vacantRoom';

  const VacantRoom({Key? key}) : super(key: key);

  @override
  _VacantRoomState createState() => _VacantRoomState();
}

class _VacantRoomState extends State<VacantRoom> {
  double width = 0.0;
  List<User> tenantList = <User>[];
  bool isLoading = true;
  Room args = Room(latitude: 0.0, longitude: 0.0);

  final TextEditingController _emailController = TextEditingController();
  double height = 0.0;

  @override
  void initState() {
    setData("");
    super.initState();
  }

  setData(String email) async {
    setState(() {
      isLoading = true;
    });
    List<User> userList = <User>[];
    var query = email.isNotEmpty
        ? _fireStore
            .collection('Users')
            .where("Type", isEqualTo: "tenant")
            .where("Email", isEqualTo: email)
            .get()
        : _fireStore.collection('Users').where("Type", isEqualTo: "tenant").get();
    await query.then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          userList.add(User.fromFireStoreSnapshot(doc));
        }
      }
    });

    setState(() {
      userList[0].isSelected = true;
      tenantList.clear();
      tenantList.addAll(userList);
      tenantList.removeWhere((element) => element.roomName!.isNotEmpty);
      isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)!.settings.arguments as Room;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal!;
    height = SizeConfig.safeBlockVertical!;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      appBar: AppBar(
        backgroundColor: ColorData.primaryColor,
        title: const Text("Listing Detail"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(child: _createBody()),
          Visibility(
            visible: isLoading,
            child: CustomProgressIndicatorWidget(),
          ),
        ],
      ),
    );
  }

  Widget _createBody() {
    return Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: (CrossAxisAlignment.start), children: [
          _createRoomWidget(),
          const SizedBox(
            height: 20,
          ),
          const BuildText(
            text: "Location",
            weight: FontWeight.bold,
            fontSize: 16.0,
          ),
          const SizedBox(
            height: 10,
          ),
          _createLocationWidget(),
          const SizedBox(
            height: 10,
          ),
          const BuildText(
            text: "Add Tenant",
            weight: FontWeight.bold,
            fontSize: 16.0,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by email',
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0), borderSide: BorderSide.none),
                  ),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setData(_emailController.text.toString());
                },
                child: Container(
                  width: width * 15,
                  height: width * 15,
                  decoration: BoxDecoration(
                      color: ColorData.primaryColor,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5), bottomRight: Radius.circular(5))),
                  child: const Center(
                    child: Icon(
                      Icons.search_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: width * 90,
            child: _createTenantListWidget(),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xff09548c),
            ),
            child: InkWell(
              onTap: () {
                updateRoom();
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.login_sharp,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        'MOVE IN',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]));
  }

  void updateRoom() {
    setState(() {
      isLoading = true;
    });
    var tenant = User();
    for (User data in tenantList) {
      if (data.isSelected!) {
        tenant = data;
        tenant.roomName = args.listingNo;
        break;
      }
    }
    _fireStore
        .collection('Users')
        .doc(tenant.documentId)
        .update({"Room Name": args.listingNo})
        .then((value) {})
        .catchError((error) => print("Failed to add data: $error"));

    _fireStore
        .collection('Rooms')
        .doc(args.documentId)
        .update({"Tenant Email": tenant.email, "Status": "Occupied"}).then((value) {
      isLoading = false;
      Navigator.pop(context, () {
        setState(() {});
      });
    }).catchError((error) => print("Failed to add data: $error"));
  }

  Widget _createTenantListWidget() {
    return tenantList.isNotEmpty
        ? ListView.builder(
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.pushNamed(context, VacantRoom.route);
              },
              child: TenantWidget(
                index: index,
                onTap: (index, isSelected) {
                  tenantList[index].isSelected = isSelected;
                  for (int i = 0; i < tenantList.length; i++) {
                    if (i != index) tenantList[i].isSelected = false;
                  }
                  setState(() {});
                  //room Detail
                },
                data: tenantList[index],
                width: width,
                height: height,
              ),
            ),
            itemCount: tenantList.length,
          )
        : Padding(
            padding: const EdgeInsets.only(top: 10),
            child: _getNoTenantWidget("No tenant available"),
          );
  }

  Widget _getNoTenantWidget(String title) {
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

  Widget _createLocationWidget() {
    return Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.pin_drop,
              color: ColorData.primaryColor,
            ),
            const SizedBox(
              width: 25,
            ),
            BuildText(
              text: "Lainchaur Kathmandu ,Nepal",
            )
          ],
        ));
  }

  Widget _createRoomWidget() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            height: 90,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                args.imagesLinkList!.first.toString(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          BuildText(
            text: args.type.toString() + " No. " + args.listingNo.toString(),
            textAlign: TextAlign.center,
            fontSize: 24.0,
          ),
        ],
      ),
    );
  }
}
