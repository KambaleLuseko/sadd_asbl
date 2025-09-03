import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextWidgets {
  static textWithLabel({
    required String title,
    required double fontSize,
    required Color textColor,
    required String value,
    int? maxLines = 3,
    bool? invertStyle = false,
    CrossAxisAlignment? align = CrossAxisAlignment.start,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: align!,
        children: [
          Container(
            // width: double.maxFinite,
            padding: EdgeInsets.zero,
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: invertStyle == true
                    ? FontWeight.bold
                    : FontWeight.w300,
                fontSize: fontSize,
                color: textColor.withOpacity(invertStyle == true ? 1 : 0.7),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            // width: double.maxFinite,
            padding: EdgeInsets.zero,
            child: Text(
              value,
              textAlign: TextAlign.left,
              maxLines: maxLines!,
              style: TextStyle(
                fontWeight: invertStyle == true
                    ? FontWeight.w300
                    : FontWeight.bold,
                fontSize: fontSize,
                color: textColor.withOpacity(invertStyle == false ? 1 : 0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static textHorizontalWithLabel({
    required String title,
    required double fontSize,
    required Color textColor,
    int? maxLines = 1,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              // width: double.maxFinite,
              padding: EdgeInsets.zero,
              child: Text(
                title,
                maxLines: maxLines,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: fontSize,
                  color: textColor.withOpacity(0.7),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            // width: double.maxFinite,
            // padding: EdgeInsets.zero,
            child: Text(
              value,
              textAlign: TextAlign.left,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: fontSize,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static textNormal({
    required String title,
    required double fontSize,
    required Color textColor,
    int? maxLines = 1,
    TextAlign align = TextAlign.left,
  }) {
    return Container(
      // width: double.maxFinite,
      padding: EdgeInsets.zero,
      child: Text(
        title,
        textAlign: align,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: fontSize, color: textColor),
      ),
    );
  }

  static text300({
    required String title,
    required double fontSize,
    required Color textColor,
    TextAlign align = TextAlign.left,
    int? maxLines = 1,
  }) {
    return Container(
      padding: EdgeInsets.zero,
      child: Text(
        title,
        textAlign: align,
        maxLines: maxLines,

        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w300,
          color: textColor,
        ),
      ),
    );
  }

  static text500({
    required String title,
    required double fontSize,
    required Color textColor,
    int? maxLines = 1,
    TextAlign align = TextAlign.left,
  }) {
    return Container(
      padding: EdgeInsets.zero,
      child: Text(
        title,
        textAlign: align,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  static textBold({
    required String title,
    required double fontSize,
    required Color textColor,
    int? maxLines = 1,
    TextAlign align = TextAlign.left,
  }) {
    return Container(
      padding: EdgeInsets.zero,
      child: Text(
        title,
        textAlign: align,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
