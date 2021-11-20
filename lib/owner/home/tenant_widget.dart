import 'package:flutter/material.dart';
import 'package:gharbeti_ui/owner/home/entity/room_container.dart';
import 'package:gharbeti_ui/owner/listings/entity/user_container.dart';
import 'package:gharbeti_ui/owner/listings/service/storage_service.dart';
import 'package:gharbeti_ui/shared/widget/build_text.dart';

class TenantWidget extends StatefulWidget {
  final int index;
  final double width;
  final double height;
  final User data;
  final Function(int index, bool isSelected) onTap;

  const TenantWidget({
    Key? key,
    required this.index,
    required this.width,
    required this.height,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  @override
  State<TenantWidget> createState() => _TenantWidgetState();
}

class _TenantWidgetState extends State<TenantWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap(widget.index, true);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildText(
                    text: widget.data.name!,
                    fontSize: 15,
                    weight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: widget.width * 4,
                  ),
                  BuildText(
                    text: widget.data.email!,
                    fontSize: 12,
                    weight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: widget.width * 4,
                  ),
                  BuildText(
                    text: widget.data.phoneNumber!,
                    fontSize: 12,
                    weight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: widget.width * 4,
                  ),
                ],
              ),
            ),
            Checkbox(
              value: widget.data.isSelected,
              activeColor: Colors.green,
              onChanged: (Object? value) {},
            ),
          ],
        ),
      ),
    );
  }
}
