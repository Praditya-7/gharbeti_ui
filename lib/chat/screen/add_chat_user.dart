import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/chat/model/chat_user.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';
import 'package:gharbeti_ui/owner/listings/entity/user_container.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/data_class.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chat_detail_screen.dart';
import 'new_user_widget.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class AddChatUserScreen extends StatefulWidget {
  const AddChatUserScreen({Key? key}) : super(key: key);
  static const routeName = "/AddChatUserScreen";

  @override
  _AddChatUserScreenState createState() => _AddChatUserScreenState();
}

class _AddChatUserScreenState extends State<AddChatUserScreen> {
  bool isApiHit = false;
  bool isLoading = true;
  String userName = "";
  List<User> userList = [];
  List<String> emailList = [];
  String email = "";
  String documentId = "";

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    if (!isApiHit) {
      await setData();
      setState(() {
        isApiHit = true;
        isLoading = false;
      });
    }

    super.didChangeDependencies();
  }

  setData() async {
    userList.clear();
    emailList.clear();
    final pref = await SharedPreferences.getInstance();
    email = pref.getString("email")!;
    var type = pref.getString("type")!;
    if (type != "tenant") {
      List<Room> roomList = [];
      var ownerQuery = _fireStore
          .collection('Room')
          .where("OwnerEmail", isEqualTo: email)
          .get();
      await ownerQuery.then((value) {
        if (value.docs.isNotEmpty) {
          for (var doc in value.docs) {
            roomList.add(Room.fromFireStoreSnapshot(doc));
          }
        }
      });
      for (var roomData in roomList) {
        if (roomData.tenantEmail != "") {
          emailList.add(roomData.tenantEmail!);
        }
      }
    }
    getUserList(type);
  }

  getUserList(String type) async {
    var query = (type == "tenant")
        ? _fireStore.collection('Users').where("Type", isEqualTo: "owner").get()
        : _fireStore.collection('Users').where("Email", isEqualTo: email).get();
    await query.then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          userList.add(User.fromFireStoreSnapshot(doc));
        }
      }
    });
    for (var data in DataClass.getInstance.getData()) {
      userList.removeWhere((item) => item.email == data);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _createBody(context),
        Visibility(
            visible: isLoading,
            child: const Center(child: CircularProgressIndicator())),
      ],
    );
  }

  Widget _createBody(BuildContext context) {
    final width = SizeConfig.safeBlockHorizontal;
    final height = SizeConfig.safeBlockVertical;

    return Scaffold(
      body: Container(
        color: ColorData.primaryColor,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height! * 5,
            ),
            IconButton(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: BuildText(
                text: "New Chat",
                fontSize: width! * 8,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: height * 3,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 30),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                    ),
                    color: Colors.white),
                child: ListView.builder(
                  itemBuilder: (context, index) => NewUserWidget(
                    data: userList[index],
                    index: index,
                    width: width,
                    onTap: (index) {
                      addChat(userList[index].email!, index);
                    },
                  ),
                  itemCount: userList.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void addChat(String userEmail, int index) {
    Map<String, dynamic> data = <String, dynamic>{
      "participants": "$email,$userEmail",
      "messageData": []
    };
    _fireStore
        .collection('Chat')
        .add(data)
        .then((value) => getId(userEmail, index))
        .catchError((error) => print("Failed to add data: $error"));
  }

  Future<void> getId(String userEmail, int index) async {
    var query = _fireStore.collection('Chat').get();
    List<ChatUser> chatDataList = [];
    await query.then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          chatDataList.add(ChatUser.fromFireStoreSnapshot(doc));
        }
      }
    });
    filterData(chatDataList, userEmail, index);
  }

  filterData(List<ChatUser> chatDataList, String email, int index) async {
    for (var chatData in chatDataList) {
      var participants = chatData.participant!;
      if (participants.contains(email)) {
        Navigator.of(context).pushNamed(ChatDetailScreen.routeName,
            arguments: ChatDetailScreen(
              id: chatData.documentId!,
              title: userList[index].name!,
            ));
        break;
      }
    }
  }
}
