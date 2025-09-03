import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../Constants/app_providers.dart';
import '../Constants/enums.dart';
import '../Constants/global_variables.dart';
import '../Helpers/local_data.helper.dart';
import '../Helpers/sync_online_local.dart';
import '../Models/user.model.dart';
import 'menu_provider.dart';

class UserProvider extends ChangeNotifier {
  String keyName = 'users';
  List<UserModel> offlineData = [];

  save({
    required UserModel data,
    EnumActions? action = EnumActions.SAVE,
    required Function callback,
  }) async {
    if (data.fullname!.isEmpty || data.phoneNumber!.isEmpty) {
      ToastNotification.showToast(
        msg: "Veuillez remplir tous les champs",
        msgType: MessageType.error,
        title: "Erreur",
      );
      return;
    }
    Response res;
    if (action == EnumActions.UPDATE) {
      res = await AppProviders.appProvider.httpPut(
        url: "${BaseUrl.user}/${data.id}",
        body: data.toJSON(),
      );
    } else {
      res = await AppProviders.appProvider.httpPost(
        url: BaseUrl.signUp,
        body: data.toJSON(),
      );
    }
    // print(res.body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      // savedData.syncStatus = 1;
      // LocalDataHelper.saveData(key: keyName, value: savedData.toJSON());
      ToastNotification.showToast(
        msg:
            jsonDecode(res.body)['message'] ?? "Utilisateur ajouté avec succès",
        msgType: MessageType.success,
        title: "Success",
      );
    }
    if (res.statusCode == 500) {
      // LocalDataHelper.saveData(key: keyName, value: data.toJSON());
      ToastNotification.showToast(
        msg:
            jsonDecode(res.body)['message'] ??
            'Une erreur est survenue, sauvegarde hors connexion en cours...',
        msgType: MessageType.info,
        title: "Information",
      );
    }
    if (res.statusCode > 299 && res.statusCode != 500) {
      ToastNotification.showToast(
        msg:
            jsonDecode(res.body)['message'] ??
            'Une erreur est survenue, Veuillez réessayer',
        msgType: MessageType.error,
        title: "Erreur",
      );
      return;
    }
    notifyListeners();
    callback();
  }

  getOffline({bool? isRefresh = false}) async {
    if (isRefresh == false && offlineData.isNotEmpty) return;
    List data = await LocalDataHelper.getData(key: keyName);
    if (data.isEmpty && isRefresh == false) {
      get(isRefresh: isRefresh);
      return;
    }
    // print(data.length);
    offlineData = List<UserModel>.from(
      data.map((item) => UserModel.fromJSON(item)).toList(),
    );
    notifyListeners();
  }

  get({bool? isRefresh = false}) async {
    if (isRefresh == false && offlineData.isNotEmpty) return;
    String url = BaseUrl.user;
    if (navKey.currentContext!
            .read<UserProvider>()
            .userLogged!
            .user
            .idSociete !=
        null) {
      url =
          "$url/society/${navKey.currentContext?.read<UserProvider>().userLogged!.user.idSociete}";
    } else {
      url = "$url/find-admin/all-admin/specs/true";
    }
    var response = await AppProviders.appProvider.httpGet(url: url);
    List data = [];
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
    }
    List<UserModel> dataList = List<UserModel>.from(
      data.map((item) {
        UserModel singleItem = UserModel.fromJSON(item);
        return singleItem;
      }).toList(),
    );

    LocalDataHelper.clearLocalData(key: keyName);
    getOffline(isRefresh: true);
    offlineData = dataList;
    SyncOnlineLocalHelper.insertNewDataOffline(
      onlineData: dataList.map((e) => e.toJSON()).toList(),
      offlineData: offlineData.map((e) => e.toJSON()).toList(),
      key: keyName,
      callback: () {
        getOffline(isRefresh: true);
      },
    );
    notifyListeners();
  }

  // validateSearch({required List<UserModel> data}) {
  //   filteredData = data;
  //   notifyListeners();
  // }

  login({required Map data, required Function callback}) async {
    if (data['username'].isEmpty || data['password'].isEmpty) {
      ToastNotification.showToast(
        msg: "Veuillez remplir tous les champs",
        msgType: MessageType.error,
        title: "Erreur",
      );
      return;
    }
    // print(query);
    Response res;
    res = await AppProviders.appProvider.httpPost(
      url: BaseUrl.signIn,
      body: {
        ...data,
        "level": data['username'].toString().contains('root')
            ? 'Root'
            : "Admin",
      },
    );
    // print(res.body);
    // return;
    if (res.statusCode == 200) {
      // print(res.body);
      Map decoded = jsonDecode(res.body);
      AuthModel authUser = AuthModel.fromJSON(decoded);

      prefs.setString("loggedUser", jsonEncode(authUser.toJSON()));
      ToastNotification.showToast(
        msg: "Connexion effectuée avec succès",
        msgType: MessageType.success,
        title: "Success",
      );
      notifyListeners();
      callback();
      return;
    }
    print(res.statusCode);
    print(res.body);
    ToastNotification.showToast(
      msg: jsonDecode(res.body)['message'],
      msgType: MessageType.error,
      title: "Error",
    );
  }

  AuthModel? userLogged;

  getUserData() async {
    userLogged = null;
    String? loggedUser = prefs.getString('loggedUser');
    userLogged = loggedUser != null
        ? AuthModel.fromJSON(jsonDecode(loggedUser))
        : null;
    // getOffline();
    // print(userLogged?.toJSON());
    // offlineData = userLogged?.society?.assets ?? [];
    // print(userLogged?.toJSON());
    notifyListeners();
  }

  logOut({required String password}) {
    prefs.clear();
    key = ValueKey(DateTime.now().toString());
    offlineData.clear();
    AppProviders.menuProvider.menus.clear();
    navKey.currentContext?.read<MenuProvider>().initDefaultMenu();

    LocalDataHelper.resetLocalData();
    userLogged = null;
    ToastNotification.showToast(
      msg: "Deconnecté",
      msgType: MessageType.success,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Navigation.pushRemove(page: const LoginPage());
    });
    notifyListeners();

    // navKey.currentContext?.read<SocketProvider>().emitWithAckEvent(
    //     eventName: "logout",
    //     data: {
    //       "username": navKey.currentContext!
    //               .read<UserProvider>()
    //               .userLogged
    //               ?.user
    //               .email ??
    //           '',
    //       "password": password,
    //       "token":
    //           navKey.currentContext?.read<UserProvider>().userLogged?.token,
    //       "level": navKey.currentContext!
    //               .read<UserProvider>()
    //               .userLogged
    //               ?.user
    //               .niveau ??
    //           ''
    //     },
    //     callback: (value) {
    //       if ((value is Map) == false) {
    //         ToastNotification.showToast(
    //             msg: "Mot de passe invalide",
    //             msgType: MessageType.error,
    //             title: "Error");
    //         return;
    //       }
    //       if (int.tryParse(value['status'].toString()) == null) {
    //         ToastNotification.showToast(
    //             msg: "Mot de passe invalide", msgType: MessageType.error);
    //         return;
    //       }
    //       if (int.parse(value['status'].toString()) != 200) {
    //         ToastNotification.showToast(
    //             msg: value['message'] ?? "Mot de passe incorrect",
    //             msgType: MessageType.error);
    //         return;
    //       }
    //       prefs.clear();
    //       key = ValueKey(DateTime.now().toString());
    //       AppProviders.usersProvider.offlineData.clear();
    //       AppProviders.menuProvider.menus.clear();
    //       userLogged = null;
    //       ToastNotification.showToast(
    //           msg: value['message'] ?? "Data validated",
    //           msgType: MessageType.success);
    //       WidgetsBinding.instance.addPostFrameCallback((_) {
    //         Navigation.pushRemove(page: const LoginPage());
    //       });
    //       notifyListeners();
    //     });
  }

  requestCode({required String email, required Function callback}) async {
    var response = await AppProviders.appProvider.httpPost(
      url: "${BaseUrl.authentication}/forgot-password",
      body: {"email": email},
    );
    // print(response.body);
    if (response.statusCode == 200) {
      ToastNotification.showToast(
        msg: 'Un code de confirmation a été envoyé à votre adresse mail',
        msgType: MessageType.success,
        title: "Information",
      );
      callback();
    }
    if (response.statusCode == 500) {
      ToastNotification.showToast(
        msg:
            jsonDecode(response.body)['message'] ??
            'Une erreur est survenue, veuillez réessayer',
        msgType: MessageType.info,
        title: "Information",
      );
    }
    if (response.statusCode != 200 && response.statusCode != 500) {
      ToastNotification.showToast(
        msg:
            jsonDecode(response.body)['message'] ??
            "L'adresse mail fournit n'a pas été trouvée",
        msgType: MessageType.error,
        title: "Erreur",
      );
      return;
    }
  }

  resetPassword({
    required String email,
    required String code,
    required String password,
    required Function callback,
  }) async {
    var response = await AppProviders.appProvider.httpPost(
      url: "${BaseUrl.authentication}/reset-password",
      body: {"email": email, "code": code, "password": password},
    );
    // print(response.body);
    if (response.statusCode == 200) {
      ToastNotification.showToast(
        msg: 'Mot de passe réinitialisé avec succès',
        msgType: MessageType.success,
        title: "Information",
      );
      callback();
    }
    if (response.statusCode == 500) {
      ToastNotification.showToast(
        msg:
            jsonDecode(response.body)['message'] ??
            'Une erreur est survenue, veuillez réessayer',
        msgType: MessageType.info,
        title: "Information",
      );
    }
    if (response.statusCode != 200 && response.statusCode != 500) {
      ToastNotification.showToast(
        msg:
            jsonDecode(response.body)['message'] ??
            "L'adresse mail fournit n'a pas été trouvée",
        msgType: MessageType.error,
        title: "Erreur",
      );
      return;
    }

    notifyListeners();
  }

  validateCode({
    required String email,
    required String code,
    required Function callback,
  }) async {
    var response = await AppProviders.appProvider.httpPost(
      url: "${BaseUrl.authentication}/confirm-email",
      body: {"email": email, "code": code},
    );
    print(email);
    print(code);
    print(response.statusCode);
    // return;
    if (response.statusCode == 200) {
      ToastNotification.showToast(
        msg: 'Adresse mail validée avec succès',
        msgType: MessageType.success,
        title: "Information",
      );
      callback();
    }
    if (response.statusCode == 500) {
      ToastNotification.showToast(
        msg:
            jsonDecode(response.body)?['message'] ??
            'Une erreur est survenue, veuillez réessayer',
        msgType: MessageType.info,
        title: "Information",
      );
    }
    if (response.statusCode != 200 && response.statusCode != 500) {
      print(response.body);
      ToastNotification.showToast(
        msg: jsonDecode(response.body)?['message'] ?? "Une erreur est survenue",
        msgType: MessageType.error,
        title: "Erreur",
      );
      return;
    }

    notifyListeners();
  }
}
