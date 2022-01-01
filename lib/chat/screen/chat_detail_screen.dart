import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/chat/model/chat_model.dart';
import 'package:gharbeti_ui/chat/model/chat_user.dart';
import 'package:gharbeti_ui/chat/screen/chat_widgetd.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class ChatDetailScreen extends StatefulWidget {
  static const routeName = "/chatDetail";
  final String id;
  final String title;

  const ChatDetailScreen({Key? key, required this.id, required this.title})
      : super(key: key);

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final List<ChatModel> chatDetailList = [];
  bool isApiHit = false;
  bool isLoading = true;
  String documentId = "";
  String header = "";
  String email = "";
  final ScrollController _controller = ScrollController();

  bool isDataClear = true;
  Timer? timer;

  // final _channel = IOWebSocketChannel.connect(
  //   Uri.parse('wss://ws.ifelse.io/'),
  // );
  @override
  void initState() {
    // initSocket();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    chatDetailList.clear();

    super.dispose();
  }

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void didChangeDependencies() async {
    if (!isApiHit) {
      final pref = await SharedPreferences.getInstance();
      email = pref.getString("email")!;
      final args =
          ModalRoute.of(context)!.settings.arguments as ChatDetailScreen;
      documentId = args.id;
      header = args.title;
      setState(() {
        isApiHit = true;
        isLoading = false;
      });
      await setData();
      // _scrollDown();
    }
    // chatDetailList.addAll(args.data.chatList!);
    super.didChangeDependencies();
  }

  setData() async {
    chatDetailList.clear();
    var query = _fireStore.collection('Chat').doc(documentId).get();
    await query.then((value) {
      if (value.exists) {
        var chatUser = ChatUser.fromJson(value.data()!);
        if (chatUser.chatList!.length > chatDetailList.length) {
          // _scrollDown();
        }
        chatDetailList.addAll(chatUser.chatList!);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = SizeConfig.safeBlockHorizontal;
    final height = SizeConfig.safeBlockVertical;
    return Stack(
      children: [
        Scaffold(
          body: _createBody(height!, context, width!),
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 0 * 450),
            height: height * 10 +
                MediaQuery.of(context).viewInsets.bottom +
                0 * 450,
            child: Align(
                alignment: Alignment.topCenter,
                child: NewMessage(
                    width: width,
                    formKey: _formKey,
                    controller: controller,
                    height: height,
                    sendMessage: () {
                      if (controller.text.isNotEmpty) {
                        sendMessage(controller.text.toString().trim());
                        controller.clear();
                      }
                    })),
          ),
        ),
        Visibility(
            visible: isLoading,
            child: const Center(child: CircularProgressIndicator())),
      ],
    );
  }

  void sendMessage(String message) {
    var chatModel = ChatModel(
      message: message,
      email: email,
      date: DateTime.now().toString(),
    );
    _fireStore.collection('Chat').doc(documentId).update({
      "messageData": FieldValue.arrayUnion([chatModel.toJson()])
    }).then((value) {
      setState(() {
        _scrollDown();
      });
      // chatDetailList.add(chatModel);
      // setState(() {});
    }).catchError((error) => print("Failed to add data: $error"));
  }

  Container _createBody(double height, BuildContext context, double width) {
    return Container(
      color: ColorData.primaryColor.withOpacity(0.3),
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: height * 8,
          ),
          _createHeader(context, width),
          SizedBox(
            height: height * 4,
          ),
          _createChatBody(width, height),
        ],
      ),
    );
  }

  Expanded _createChatBody(double width, double height) {
    return Expanded(
        child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
                color: Colors.grey.shade100),
            // child: StreamBuilder(
            //   stream: _channel.stream,
            //   builder: (context, snapshot) {
            //     return Text(snapshot.hasData ? '${snapshot.data}' : '');
            //   },
            // ),
            child: Center(
              child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  reverse: false,
                  controller: _controller,
                  itemCount: chatDetailList.length,
                  itemBuilder: (context, index) =>
                      chatDetailList[index].email == email
                          ? buildChatMsgSender(
                              width: width,
                              message: chatDetailList[index].message!,
                              time: "10:45 am")
                          : buildChatMsgReciever(
                              width: width,
                              message: chatDetailList[index].message!,
                              time: "10:45 am")),
            )));
  }

  Container _createHeader(BuildContext context, double width) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            padding: const EdgeInsets.only(left: 20, right: 25),
            onPressed: () => Navigator.of(context).pop(),
            icon:
                Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
          ),
          SizedBox(
            width: width * 20,
          ),
          Align(
            alignment: Alignment.center,
            child: BuildText(
              text: header,
              fontSize: width * 5,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
