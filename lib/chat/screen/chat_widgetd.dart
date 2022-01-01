import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/chat/model/chat_user.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';

import 'chat_detail_screen.dart';

class BuildChatListingWidget extends StatelessWidget {
  const BuildChatListingWidget({
    Key? key,
    required this.width,
    required this.index,
    required this.data,
  }) : super(key: key);

  final double width;
  final int index;
  final ChatUser data;

  @override
  Widget build(BuildContext context) {
    var message = data.chatList!.isNotEmpty
        ? data.chatList![data.chatList!.length - 1].message!
        : "";
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(ChatDetailScreen.routeName,
          arguments: ChatDetailScreen(
            id: data.documentId!,
            title: data.name!,
          )),
      child: Container(
        margin: index == 0
            ? const EdgeInsets.only(top: 0, left: 18, right: 18, bottom: 18)
            : const EdgeInsets.all(18),
        width: double.infinity,
        child: Row(
          children: [
            CircleAvatar(
              radius: width * 8,
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXtphDb-HCEglyBvY3gM3K8PrTFGE5rd61dIum_PAYyCOsPZlSj5Gp7PIWt9FGSsDxTk4&usqp=CAU"),
            ),
            SizedBox(
              width: width * 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuildText(
                  text: data.name!,
                  fontSize: width * 5,
                ),
                SizedBox(
                  width: width * 50,
                  child: BuildText(
                    text: message,
                    fontSize: width * 3.5,
                    color: Colors.grey,
                    maxLines: 1,
                  ),
                )
              ],
            ),
            SizedBox(
              width: width * 2,
            ),
            BuildText(
              text: "4 min ago",
              fontSize: width * 3,
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildChatMsgSender({
  required double width,
  required String message,
  required String time,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
    width: width * 100,
    alignment: Alignment.centerRight,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          children: [
            BuildText(
              text: time,
              fontSize: width * 3,
              color: Colors.grey,
            ),
          ],
        ),
        Bubble(
          margin: BubbleEdges.only(top: 10),
          alignment: Alignment.topRight,
          nip: BubbleNip.rightBottom,
          nipOffset: 12,
          nipWidth: 15,
          color: ColorData.primaryColor.withOpacity(0.8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: width * 60,
              child: BuildText(
                text: message,
                fontSize: width * 4,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildChatMsgReciever({
  required double width,
  required String message,
  required String time,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
    width: width * 100,
    alignment: Alignment.centerLeft,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Bubble(
          margin: const BubbleEdges.only(top: 10),
          alignment: Alignment.topRight,
          nip: BubbleNip.leftBottom,
          nipOffset: 12,
          nipWidth: 15,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: width * 60,
              child: BuildText(
                text: message,
                fontSize: width * 4,
                color: ColorData.primaryColor,
              ),
            ),
          ),
        ),
        BuildText(
          text: time,
          fontSize: width * 3,
          color: Colors.grey,
        ),
      ],
    ),
  );
}

class NewMessage extends StatefulWidget {
  const NewMessage({
    Key? key,
    required this.width,
    required GlobalKey<FormState> formKey,
    required this.controller,
    required this.height,
    required this.sendMessage,
  })  : _formKey = formKey,
        super(key: key);

  final double width;

  final GlobalKey<FormState> _formKey;
  final TextEditingController controller;
  final double height;
  final Function()? sendMessage;

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: ColorData.primaryColor.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // IconButton(
            //     onPressed: () => _showPicker(context),
            //     icon: Icon(
            //       Icons.photo_outlined,
            //       color: Colors.white,
            //       size: widget.width * 8,
            //     )),
            Expanded(
              flex: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                margin: const EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Flexible(
                      flex: 10,
                      child: Container(
                        // height: widget.height * 10,
                        alignment: Alignment.center,
                        child: Form(
                          key: widget._formKey,
                          child: TextFormField(
                            maxLines: null,
                            autofocus: false,
                            textInputAction: TextInputAction.newline,
                            style: TextStyle(
                              fontFamily: 'Noto Sans JP',
                              fontSize: widget.width * 4,
                              fontWeight: FontWeight.w400,
                            ),
                            keyboardType: TextInputType.multiline,
                            controller: widget.controller,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.all(0),
                              border: InputBorder.none,
                              hintText: "Type Here..",
                              hintStyle: TextStyle(
                                fontFamily: 'Noto Sans JP',
                                fontSize: widget.width * 4,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffB2B2B2),
                              ),
                            ),
                            onChanged: (value) {
                              print(value);
                            },
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: InkWell(
                        onTap: widget.sendMessage,
                        child: Container(
                          height: widget.height * 4,
                          width: widget.width * 5,
                          margin: const EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.send,
                            color: ColorData.primaryColor,
                            size: widget.width * 8,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
