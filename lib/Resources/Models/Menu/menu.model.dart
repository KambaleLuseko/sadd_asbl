import 'package:flutter/material.dart';

class MenuModel {
  String title;
  Widget page;
  IconData? icon;
  Map? languagesTitle;
  MenuModel(
      {required this.title,
      required this.page,
      this.icon,
      this.languagesTitle = const {'fr': ''}});

  static fromJSON(json) {
    return MenuModel(
        title: json['title'],
        page: json['page'],
        icon: json['icon'],
        languagesTitle: json['language'] ?? {'fr': ''});
  }
}
