import 'package:flutter/material.dart';

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
        page: const HomePage(),
        icon: Icons.home,
        languagesTitle: {'fr': 'A propos', 'en': "About us"},
      ),
      MenuModel(
        title: "Nous contacter",
        page: Container(),
        icon: Icons.home,
        languagesTitle: {'fr': 'Nous contacter', 'en': "Contact us"},
      ),
      // if (navKey.currentContext!
      //         .read<UserProvider>()
      //         .userLogged!
      //         .user
      //         .niveau
      //         ?.toLowerCase() ==
      //     'root') ...[
      //   MenuModel(
      //     title: "Services",
      //     page: const ServicePage(),
      //     icon: Icons.category_rounded,
      //     languagesTitle: {'fr': 'Services', 'en': "Services"},
      //   ),
      //   MenuModel(
      //     title: "Societés",
      //     page: const SocietyPage(),
      //     icon: Icons.location_city_rounded,
      //     languagesTitle: {'fr': 'Sociétés', 'en': "Companies"},
      //   ),
      //   MenuModel(
      //     title: "Employés",
      //     page: const UserPage(),
      //     icon: Icons.person,
      //     languagesTitle: {'fr': 'Agents', 'en': "Agents"},
      //   ),
      // ],
      // if (navKey.currentContext!
      //         .read<UserProvider>()
      //         .userLogged!
      //         .user
      //         .niveau
      //         ?.toLowerCase() ==
      //     'founder') ...[
      //   MenuModel(
      //     title: "Alertes",
      //     page: const AlertListPage(),
      //     icon: Icons.notifications_active_rounded,
      //     languagesTitle: {'fr': 'Alertes', 'en': "Alerts"},
      //   ),
      //   MenuModel(
      //     title: "Mission",
      //     page: const MissionPage(),
      //     icon: Icons.settings_suggest_rounded,
      //     languagesTitle: {'fr': 'Missions', 'en': "Missions"},
      //   ),
      //   MenuModel(
      //     title: "Enquêtes",
      //     page: const InvestigatioPage(),
      //     icon: Icons.content_paste_search_outlined,
      //     languagesTitle: {'fr': 'Enquêtes', 'en': "Investigations"},
      //   ),
      //   MenuModel(
      //     title: "Employés",
      //     page: const UserPage(),
      //     icon: Icons.person,
      //     languagesTitle: {'fr': 'Agents', 'en': "Agents"},
      //   ),
      //   MenuModel(
      //     title: "Affiliations",
      //     page: const ClientLinkPage(),
      //     icon: Icons.link,
      //     languagesTitle: {'fr': 'Affiliations', 'en': "Affiliations"},
      //   ),
      // ],

      // if (navKey.currentContext!
      //         .read<UserProvider>()
      //         .userLogged!
      //         .user
      //         .niveau
      //         ?.toLowerCase() ==
      //     'admin') ...[
      //   MenuModel(
      //     title: "Alertes",
      //     page: const AlertListPage(),
      //     icon: Icons.notifications_active_rounded,
      //     languagesTitle: {'fr': 'Alertes', 'en': "Alerts"},
      //   ),
      //   MenuModel(
      //     title: "Mission",
      //     page: const MissionPage(),
      //     icon: Icons.settings_suggest_rounded,
      //     languagesTitle: {'fr': 'Missions', 'en': "Missions"},
      //   ),
      //   MenuModel(
      //     title: "Enquêtes",
      //     page: const InvestigatioPage(),
      //     icon: Icons.content_paste_search_outlined,
      //     languagesTitle: {'fr': 'Enquêtes', 'en': "Investigations"},
      //   ),
      //   MenuModel(
      //     title: "Affiliations",
      //     page: const ClientLinkPage(),
      //     icon: Icons.link,
      //     languagesTitle: {'fr': 'Affiliations', 'en': "Affiliations"},
      //   ),
      // ],
      // MenuModel(
      //   title: "Profile",
      //   page: const ProfilePage(),
      //   icon: Icons.person_3_rounded,
      //   languagesTitle: {'fr': 'Profil', 'en': "Profile"},
      // ),
      // MenuModel(title: " Unités", page: Container(), icon: Icons.people),
      // MenuModel(title: "Paramètres", page: Container(), icon: Icons.settings),
    ]);
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
