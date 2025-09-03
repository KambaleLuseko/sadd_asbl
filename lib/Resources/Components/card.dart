import 'package:flutter/material.dart';

import '../../Resources/Components/texts.dart';
import '../../Resources/Constants/global_variables.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final Widget content;
  double? elevation = 0;
  Color? backColor = AppColors.kScaffoldColor;
  Color? titleColor;

  CardWidget({
    super.key,
    required this.title,
    this.elevation,
    required this.content,
    this.backColor,
    this.titleColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: backColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultPadding / 2),
      ),
      // elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextWidgets.textBold(
              title: title,
              fontSize: 18,
              textColor: titleColor ?? AppColors.kBlackColor,
            ),
            const SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(
                left: kDefaultPadding,
                top: kDefaultPadding / 2,
                right: kDefaultPadding / 2,
                bottom: kDefaultPadding / 2,
              ),
              width: double.maxFinite,
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}
