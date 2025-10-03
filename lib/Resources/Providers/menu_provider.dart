import 'package:flutter/material.dart';
import 'package:sadd_asbl/Views/About/about.page.dart';
import 'package:sadd_asbl/Views/Galery/goals.dart';
import 'package:sadd_asbl/Views/News/news.page.dart';

import '../../Views/Home/home.page.dart';
import '../Models/Menu/menu.model.dart';

class MenuProvider extends ChangeNotifier {
  initDefaultMenu() {
    menus.clear();
    menus.addAll([
      MenuModel(
        title: "Accueil",
        page: const HomePage(),
        icon: Icons.home,
        languagesTitle: {'fr': 'Accueil', 'en': "Home"},
      ),
      MenuModel(
        title: "A propos",
        page: const AboutPageWidget(),
        icon: Icons.help_outline_rounded,
        languagesTitle: {'fr': 'A propos', 'en': "About us"},
      ),
      MenuModel(
        title: "Nos objectifs",
        page: const GoalsPage(),
        icon: Icons.golf_course_sharp,
        languagesTitle: {'fr': 'Nos objectifs', 'en': "Goals"},
      ),
      MenuModel(
          title: "Réalisations",
          page: const NewsPage(),
          icon: Icons.newspaper_rounded,
          languagesTitle: {'fr': 'Réalisations', 'en': "News"}),
    ]);

    notifyListeners();
  }

  List<MenuModel> menus = [];
  initMenu() {
    initDefaultMenu();
    activePage = MenuModel(
      title: "Accueil",
      page: const HomePage(),
      icon: Icons.home,
      languagesTitle: {'fr': 'Accueil', 'en': "Home"},
    );
    // if (navKey.currentContext!
    //         .read<UserProvider>()
    //         .userLogged!
    //         .user
    //         .level
    //         ?.toLowerCase() ==
    //     'admin') {
    //   menus.insertAll(menus.length - 1, []);
    //   notifyListeners();
    // }
  }

  MenuModel activePage = MenuModel(
    title: "Accueil",
    page: const HomePage(),
    icon: Icons.home,
    languagesTitle: {'fr': 'Accueil', 'en': "Home"},
  );

  getActivePage() => activePage;

  setActivePage({required MenuModel newPage}) {
    if (activePage.title.toLowerCase() == newPage.title.toLowerCase()) return;
    activePage = newPage;
    notifyListeners();
  }
}
