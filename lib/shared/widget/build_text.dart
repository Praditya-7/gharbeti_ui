import 'package:flutter/material.dart';
import 'package:gharbeti_ui/shared/color.dart';

class BuildText extends StatelessWidget {
  const BuildText(
      {this.text = "",
      this.fontSize = 14.0,
      this.color = Colors.black,
      this.weight = FontWeight.w500,
      this.decoration = TextDecoration.none,
      this.textAlign = TextAlign.start,
      this.maxLines = 4,
      this.italics = false});

  final String text;
  final double fontSize;
  final Color color;
  final FontWeight weight;
  final TextDecoration decoration;
  final TextAlign textAlign;
  final int maxLines;
  final bool italics;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: weight,
        fontSize: fontSize,
        color: color,
        fontStyle: italics ? FontStyle.italic : FontStyle.normal,
        decoration: decoration,
        fontFamily: 'Poppins',
      ),
    );
  }
}

class BuildTextFeild extends StatefulWidget {
  const BuildTextFeild(
      {required this.width,
      required this.label,
      required this.keyBoardType,
      this.obscureText = false,
      this.validator,
      required this.controller,
      this.textInputAction = TextInputAction.done,
      required this.iconData,
      this.trailingIcon = false,
      this.showIcon = true,
      this.isEnable = true});

  final double width;
  final String label;
  final IconData iconData;
  final TextInputType keyBoardType;
  final bool obscureText;
  final TextEditingController controller;
  final validator;
  final TextInputAction textInputAction;
  final bool? trailingIcon;
  final bool? showIcon;
  final bool? isEnable;

  @override
  _BuildTextFeildState createState() => _BuildTextFeildState();
}

class _BuildTextFeildState extends State<BuildTextFeild> {
  FocusNode _focusNode = FocusNode();
  bool? obsecureText;
  @override
  void initState() {
    obsecureText = widget.obscureText;
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        onTap: () {
          setState(() {
            FocusScope.of(context).requestFocus(_focusNode);
          });
        },
        enabled: widget.isEnable,
        focusNode: _focusNode,
        maxLines: widget.textInputAction == TextInputAction.newline ? 4 : 1,
        keyboardType: widget.keyBoardType,
        obscureText: obsecureText!,
        obscuringCharacter: "*",
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
            labelText: widget.label,
            prefixIcon: widget.showIcon!
                ? Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Icon(
                      widget.iconData,
                      size: widget.width * 5,
                      color: _focusNode.hasFocus
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ), // icon is 48px widget.
                  )
                : null,
            suffixIcon: widget.trailingIcon!
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        obsecureText = !obsecureText!;
                      });
                    },
                    padding: const EdgeInsets.all(0),
                    icon: Icon(
                      !obsecureText! ? Icons.visibility : Icons.visibility_off,
                      size: widget.width * 5,
                      color: _focusNode.hasFocus
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ))
                : SizedBox.shrink(), // icon ,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(),
            ),
            //fillColor: Colors.green
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: ColorData.primaryColor,
              ),
            ),
            labelStyle: TextStyle(
                color: _focusNode.hasFocus
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
                fontSize: widget.width * 4),
            focusColor: ColorData.primaryColor,
            errorBorder: InputBorder.none),
        onChanged: (value) {
          value = widget.controller.text;
        },
      ),
    );
  }
}

class BuildTextFieldIcons extends StatefulWidget {
  const BuildTextFieldIcons({
    required this.width,
    required this.label,
    required this.keyBoardType,
    this.obscureText = false,
    this.validator,
    required this.controller,
    required this.leadingIcon,
    required this.trailingIcon,
  });

  final double width;
  final String label;

  final TextInputType keyBoardType;
  final bool obscureText;
  final TextEditingController controller;
  final Widget leadingIcon;
  final Widget trailingIcon;
  final validator;

  @override
  _BuildTextFieldIcons createState() => _BuildTextFieldIcons();
}

class _BuildTextFieldIcons extends State<BuildTextFieldIcons> {
  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      onTap: () {
        setState(() {
          FocusScope.of(context).requestFocus(_focusNode);
        });
      },
      focusNode: _focusNode,
      keyboardType: widget.keyBoardType,
      obscureText: widget.obscureText,
      obscuringCharacter: "*",
      decoration: InputDecoration(
          prefixIcon: widget.leadingIcon,
          suffixIcon: widget.trailingIcon,
          border: InputBorder.none,
          hintText: widget.label,
          hintStyle: TextStyle(
              color: _focusNode.hasFocus
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
              fontSize: widget.width * 3.5),
          focusColor: Theme.of(context).primaryColor,
          errorBorder: OutlineInputBorder()),
      onChanged: (value) {
        value = widget.controller.text;
      },
    );
  }
}

class BuildTextFieldBorder extends StatefulWidget {
  const BuildTextFieldBorder({
    required this.width,
    required this.label,
    required this.keyBoardType,
    this.obscureText = false,
    this.validator,
    required this.controller,
  });

  final double width;
  final String label;

  final TextInputType keyBoardType;
  final bool obscureText;
  final TextEditingController controller;

  final validator;

  @override
  _BuildTextFieldBorder createState() => _BuildTextFieldBorder();
}

class _BuildTextFieldBorder extends State<BuildTextFieldBorder> {
  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      onTap: () {
        setState(() {
          FocusScope.of(context).requestFocus(_focusNode);
        });
      },
      focusNode: _focusNode,
      keyboardType: widget.keyBoardType,
      obscureText: widget.obscureText,
      obscuringCharacter: "*",
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintText: widget.label,
          hintStyle: TextStyle(
              color: _focusNode.hasFocus
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
              fontSize: widget.width * 4),
          focusColor: Theme.of(context).primaryColor,
          errorBorder: OutlineInputBorder()),
      onChanged: (value) {
        value = widget.controller.text;
      },
    );
  }
}
