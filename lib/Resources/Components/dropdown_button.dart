import 'package:flutter/material.dart';

import '../../Resources/Constants/global_variables.dart';
import 'texts.dart';

class CustomDropdownButton extends StatelessWidget {
  final String hintText;
  final String? value;
  final List<String> items;
  bool? displayLabel;
  Function callBack;
  Color? textColor = AppColors.kWhiteColor.withOpacity(0.7);
  Color? dropdownColor = AppColors.kBlackLightColor;
  Color? backColor = AppColors.kTextFormWhiteColor;
  CustomDropdownButton({
    super.key,
    required this.value,
    required this.hintText,
    required this.callBack,
    this.textColor,
    this.dropdownColor,
    this.backColor,
    required this.items,
    this.displayLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (displayLabel == true)
            Text(hintText, style: TextStyle(color: textColor)),
          if (displayLabel == true) const SizedBox(height: 0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: backColor,
              borderRadius: BorderRadius.circular(kDefaultPadding / 4),
            ),
            child: DropdownButton(
              underline: Container(),
              dropdownColor: dropdownColor,
              hint: TextWidgets.text300(
                title: hintText,
                fontSize: 14,
                textColor:
                    textColor?.withOpacity(0.5) ??
                    Colors.white.withOpacity(0.5),
              ),
              isExpanded: hintText.isNotEmpty ? true : false,
              items: items.map((element) {
                return DropdownMenuItem(
                  value: element,
                  child: Text(element, style: TextStyle(color: textColor)),
                );
              }).toList(),
              onChanged: (value) {
                callBack(value);
              },
              value: value,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDynamicDropdownButton extends StatelessWidget {
  final String hintText;
  final String? value;
  final List<DropDownItemModel> items;
  Function callBack;
  Color? textColor = AppColors.kWhiteColor.withOpacity(0.7);
  Color? dropdownColor = AppColors.kBlackLightColor;
  Color? backColor = AppColors.kTextFormWhiteColor;
  CustomDynamicDropdownButton({
    super.key,
    required this.value,
    required this.hintText,
    required this.callBack,
    this.textColor,
    this.dropdownColor,
    this.backColor,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(hintText, style: TextStyle(color: textColor)),
          const SizedBox(height: 0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: backColor,
              borderRadius: BorderRadius.circular(kDefaultPadding / 4),
            ),
            child: DropdownButton(
              underline: Container(),
              dropdownColor: dropdownColor,
              isExpanded: true,
              items: items.map((element) {
                return DropdownMenuItem(
                  value: element.indexColumn,
                  child: Text(
                    element.displayColumn,
                    style: TextStyle(color: textColor),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                callBack(value);
              },
              value: value,
            ),
          ),
        ],
      ),
    );
  }
}

class DropDownItemModel {
  final String displayColumn, indexColumn;
  DropDownItemModel({required this.displayColumn, required this.indexColumn});
}
