import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/chat/model/chat_user.dart';
import 'package:gharbeti_ui/owner/listings/entity/user_container.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';

import 'chat_detail_screen.dart';

class NewUserWidget extends StatelessWidget {
  const NewUserWidget({
    Key? key,
    required this.width,
    required this.index,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  final double width;
  final int index;
  final User data;
  final Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(index);
      },
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
              ],
            ),
            SizedBox(
              width: width * 2,
            ),
          ],
        ),
      ),
    );
  }
}
