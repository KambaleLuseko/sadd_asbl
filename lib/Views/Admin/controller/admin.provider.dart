import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sadd_asbl/Resources/Constants/app_providers.dart';
import 'package:sadd_asbl/Resources/Constants/enums.dart';
import 'package:sadd_asbl/Resources/Constants/global_variables.dart';
import 'package:sadd_asbl/Resources/Constants/navigators.dart';
import 'package:sadd_asbl/Views/Admin/admin.page.dart';

class AdminProvider extends ChangeNotifier {
  UserSession? user;

  setUser(UserSession user) {
    this.user = user;
    notifyListeners();
  }

  login({required String email, required String password}) async {
    var response = await AppProviders.appProvider.httpPost(
        url: BaseUrl.getData,
        body: {
          "username": email,
          "password": password,
          "transaction": "login"
        });
    // print(response.body);
    List data = [];
    if (response.statusCode == 200) {
      data =
          jsonDecode(response.body) is String ? [] : jsonDecode(response.body);
    }
    if (data.isEmpty) {
      ToastNotification.showToast(
          msg: "Identifiants invalides",
          msgType: MessageType.error,
          title: 'Error');
      return;
    }
    user = UserSession(
        id: int.tryParse(data.first['id']),
        email: data.first['admin'],
        password: data.first['password']);
    // print(data);
    Navigation.pushReplaceNavigate(page: const AdminPage());
  }
}

class UserSession {
  final int? id;
  final String email;
  final String? password;
  UserSession({required this.email, this.password, this.id});
}
