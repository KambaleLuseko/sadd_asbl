import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sadd_asbl/Resources/Constants/app_providers.dart';
import 'package:sadd_asbl/Resources/Constants/enums.dart';
import 'package:sadd_asbl/Resources/Constants/global_variables.dart';
import 'package:sadd_asbl/Views/News/model/news.model.dart';

class NewsProvider extends ChangeNotifier {
  List<NewsModel> offlineData = [], displayedData = [], carousselData = [];

  getOffline({bool? isRefresh = false}) async {
    // if (isRefresh == false && offlineData.isNotEmpty) return;
    // List data = await LocalDataHelper.getData(key: keyName);
    // if (data.isEmpty && isRefresh == false) {
    //   get(isRefresh: isRefresh);
    //   return;
    // }
    // // print(data.length);
    // offlineData = List<UserModel>.from(
    //   data.map((item) => UserModel.fromJSON(item)).toList(),
    // );
    // notifyListeners();
  }

  get({bool? isRefresh = false}) async {
    if (isRefresh == false && offlineData.isNotEmpty) return;
    String url = BaseUrl.getData;
    var response = await AppProviders.appProvider
        .httpPost(url: url, body: {"transaction": "news"});
    // print(response.body);
    List data = [];
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
    }
    List<NewsModel> dataList = List<NewsModel>.from(
      data.map((item) {
        NewsModel singleItem = NewsModel.fromJson(item);
        return singleItem;
      }).toList(),
    );

    // LocalDataHelper.clearLocalData(key: keyName);
    getOffline(isRefresh: true);
    offlineData = dataList;
    carousselData = dataList.length > 10 ? dataList.sublist(0, 10) : dataList;
    changePage(action: 'first');
    // print(offlineData.length);
    // SyncOnlineLocalHelper.insertNewDataOffline(
    //   onlineData: dataList.map((e) => e.toJSON()).toList(),
    //   offlineData: offlineData.map((e) => e.toJSON()).toList(),
    //   key: keyName,
    //   callback: () {
    //     getOffline(isRefresh: true);
    //   },
    // );
    notifyListeners();
  }

  int itemPerPage = 10;
  int currentPage = 1;
  int get pageCount => (offlineData.length / itemPerPage).ceil();
  changePage({required String action}) {
    if (action.toLowerCase() == 'first') {
      currentPage = 1;
    } else if (action.toLowerCase() == 'previous') {
      if (currentPage > 1) {
        currentPage--;
      }
    } else if (action.toLowerCase() == 'next') {
      if (currentPage < pageCount) {
        currentPage++;
      } else {
        currentPage = pageCount;
      }
    }
    displayedData = offlineData
        .skip((currentPage - 1) * itemPerPage)
        .take(itemPerPage)
        .toList();
    notifyListeners();
  }

  save({
    required NewsModel data,
    EnumActions? action = EnumActions.SAVE,
    required Function callback,
  }) async {
    if (data.contenu!.isEmpty) {
      ToastNotification.showToast(
        msg: "Veuillez specifier le contenu",
        msgType: MessageType.error,
        title: "Erreur",
      );
      return;
    }
    if (data.image == null ||
        data.image!.isEmpty ||
        data.image2 == null ||
        data.image2!.isEmpty) {
      ToastNotification.showToast(
        msg: "Veuillez choisir les image",
        msgType: MessageType.error,
        title: "Erreur",
      );
      return;
    }
    Response res;
    if (action == EnumActions.UPDATE) {
      res = await AppProviders.appProvider.httpPut(
        url: "${BaseUrl.saveData}/${data.id}",
        body: {...data.toJson(), 'transaction': "news"},
      );
    } else {
      res = await AppProviders.appProvider.httpPost(
        url: BaseUrl.saveData,
        body: {...data.toJson(), 'transaction': "news"},
      );
    }
    if (res.statusCode == 200 || res.statusCode == 201) {
      // savedData.syncStatus = 1;
      // LocalDataHelper.saveData(key: keyName, value: savedData.toJSON());
      ToastNotification.showToast(
        msg:
            jsonDecode(res.body)['message'] ?? "Utilisateur ajouté avec succès",
        msgType: MessageType.success,
        title: "Success",
      );
      notifyListeners();
      callback();
    }
    if (res.statusCode == 500) {
      // LocalDataHelper.saveData(key: keyName, value: data.toJSON());
      ToastNotification.showToast(
        msg: jsonDecode(res.body)['message'] ??
            'Une erreur est survenue, sauvegarde hors connexion en cours...',
        msgType: MessageType.error,
        title: "Error",
      );
    }
    if (res.statusCode > 299 && res.statusCode != 500) {
      ToastNotification.showToast(
        msg: jsonDecode(res.body)['message'] ??
            'Une erreur est survenue, Veuillez réessayer',
        msgType: MessageType.error,
        title: "Erreur",
      );
      return;
    }
  }
}
