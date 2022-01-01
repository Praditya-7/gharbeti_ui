import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gharbeti_ui/chat/model/chat_model.dart';
import 'package:gharbeti_ui/chat/model/chat_user.dart';
import 'package:gharbeti_ui/chat/screen/add_chat_user.dart';
import 'package:gharbeti_ui/owner/listings/entity/user_container.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/data_class.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';
import 'package:gharbeti_ui/shared/widget/no_internet_connection.dart';
import 'package:gharbeti_ui/signup/entity/Users.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chat_widgetd.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const routeName = "/ChatScreen";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult? _connectionStatus;
  StreamSubscription<ConnectivityResult>? connectivitySubscription;
  List<ChatUser> chatList = [];
  List<String> removeUserList = [];
  bool isApiHit = false;
  bool isLoading = true;
  String userName = "";

  @override
  void initState() {
    initConnectivity();
    super.initState();
  }

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
    List<ChatUser> chatDataList = [];
    chatList.clear();
    final pref = await SharedPreferences.getInstance();
    var email = pref.getString("email");
    var query = _fireStore.collection('Chat').get();
    await query.then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          chatDataList.add(ChatUser.fromFireStoreSnapshot(doc));
        }
      }
    });
    filterData(chatDataList, email!);
  }

  filterData(List<ChatUser> chatDataList, String email) async {
    for (var chatData in chatDataList) {
      var participants = chatData.participant!;
      if (participants.contains(email)) {
        await getUserData(participants, email);
        chatData.name = userName;
        chatList.add(chatData);
        setState(() {});
      }
    }

    DataClass.getInstance.setData(removeUserList);
  }

  getUserData(String participants, String email) async {
    var split = participants.split(",");
    String name = "";
    for (var splitData in split) {
      if (splitData != email) {
        name = splitData;
        removeUserList.add(name);
        break;
      }
    }
    User? userData;
    var query =
        _fireStore.collection('Users').where("Email", isEqualTo: name).get();
    await query.then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          userData = User.fromFireStoreSnapshot(doc);
        }
      }
    });
    userName = userData!.name!;
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (mounted) {
      setState(() {
        _connectionStatus = result;
      });
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
                text: "Messages",
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
                  itemBuilder: (context, index) => BuildChatListingWidget(
                    width: width,
                    index: index,
                    data: chatList[index],
                  ),
                  itemCount: chatList.length,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddChatUserScreen.routeName);
        },
        child: const Icon(
          Icons.message,
          color: Colors.white,
        ),
        backgroundColor: ColorData.primaryColor,
      ),
    );
  }
}
