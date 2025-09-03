import 'package:flutter/material.dart';

import '../../Resources/Components/texts.dart';
import '../../Resources/Constants/global_variables.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String hintText;
  String? labelText;
  final Color textColor;
  final Color backColor;
  final bool? isEnabled;
  bool? isObsCured;
  final TextEditingController? editCtrller;
  int? maxLines;
  int maxLength = 255;
  TextInputType? inputType;
  bool? isBordered;
  TextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.textColor,
    required this.backColor,
    this.editCtrller,
    this.labelText,
    this.inputType,
    maxLength,
    this.maxLines = 1,
    this.isEnabled,
    this.isObsCured,
    this.isBordered = false,
  });

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      width: double.maxFinite,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: widget.backColor,
          borderRadius: BorderRadius.circular(kDefaultPadding / 4),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(kDefaultPadding / 4),
              child: TextFormField(
                enabled: widget.isEnabled != null ? widget.isEnabled! : true,
                obscureText: widget.isObsCured != null
                    ? widget.isObsCured!
                    : false,
                maxLines: widget.maxLines,
                style: TextStyle(color: widget.textColor),
                textAlign: TextAlign.left,
                controller: widget.editCtrller,
                keyboardType: widget.inputType,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: widget.textColor.withOpacity(0.5),
                  ),
                  label: TextWidgets.text300(
                    title: widget.labelText ?? widget.hintText,
                    fontSize: 12,
                    textColor: widget.textColor.withOpacity(1),
                  ),
                  enabledBorder: widget.isBordered == true
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: widget.textColor.withOpacity(0.2),
                            width: 1,
                          ),
                        )
                      : InputBorder.none,
                  border: widget.isBordered == true
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: widget.textColor,
                            width: 1,
                          ),
                        )
                      : InputBorder.none,
                  focusedBorder: widget.isBordered == true
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: widget.textColor,
                            width: 1,
                          ),
                        )
                      : InputBorder.none,
                  // hintText: widget.hintText,
                  // hintStyle:
                  //     TextStyle(color: widget.textColor.withOpacity(0.5))
                ),
              ),
            ),
            if (widget.isObsCured != null)
              Positioned(
                top: 0,
                bottom: 0,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    widget.isObsCured = !widget.isObsCured!;
                    setState(() {});
                  },
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: widget.textColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(
                          kDefaultPadding / 4,
                        ),
                      ),
                      child: Icon(
                        widget.isObsCured != null && widget.isObsCured == false
                            ? Icons.vpn_key_rounded
                            : Icons.remove_red_eye,
                        color: widget.textColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class TextFormVerification extends StatefulWidget {
  final String hintText;
  final Color textColor;
  final Color backColor;
  final TextEditingController editCtrller;
  int maxLines = 1;

  TextFormVerification({
    super.key,
    required this.hintText,
    required this.textColor,
    required this.backColor,
    required this.editCtrller,
    required this.maxLines,
  });

  @override
  _TextFormVerificationState createState() => _TextFormVerificationState();
}

class _TextFormVerificationState extends State<TextFormVerification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: double.maxFinite,
      child: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: widget.backColor,
          borderRadius: BorderRadius.circular(kDefaultPadding / 4),
        ),
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          obscureText: false,
          maxLines: widget.maxLines,
          style: TextStyle(color: widget.textColor),
          textAlign: TextAlign.center,
          decoration: InputDecoration.collapsed(
            // contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            hintText: widget.hintText,
            hintStyle: TextStyle(color: widget.textColor.withOpacity(0.5)),
            // border: UnderlineInputBorder(
            //     borderSide: BorderSide(color: widget.textColor, width: 1)),
            // focusedBorder: UnderlineInputBorder(
            //     borderSide: BorderSide(color: widget.textColor, width: 3)),
            // hintText: widget.hintText,
            // hintStyle:
            //     TextStyle(color: widget.textColor.withOpacity(0.5))
          ),
        ),
      ),
    );
  }
}
