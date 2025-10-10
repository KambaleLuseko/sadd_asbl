import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadd_asbl/Views/Admin/video.widget.dart';

import '../../Resources/Components/button.dart';
import '../../Resources/Components/decorated_container.dart';
import '../../Resources/Components/texts.dart';
import '../../Resources/Constants/global_variables.dart';
import '../../Resources/Constants/navigators.dart';
import '../../Resources/Models/Menu/menu.model.dart';
import '../News/add_news.page.dart';
import '../main.page.dart';
import 'controller/admin.provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Widget activePage = Container();
  @override
  void initState() {
    super.initState();
    activePage = menus[0].page;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kScaffoldColor,
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: 800,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    children: [
                      ...List.generate(
                          menus.length,
                          (index) => GestureDetector(
                                onTap: () {
                                  activePage = menus[index].page;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 8),
                                  margin: const EdgeInsets.only(right: 16),
                                  decoration: BoxDecoration(
                                    color: AppColors.kPrimaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: TextWidgets.textNormal(
                                      title: menus[index].title,
                                      fontSize: 16,
                                      textColor: AppColors.kWhiteColor),
                                ),
                              )),
                      const Spacer(),
                      IconButtonWidget(
                          backColor: AppColors.kTransparentColor,
                          textColor: AppColors.kWhiteColor,
                          callback: () {
                            context.read<AdminProvider>().user = null;
                            Navigation.pushRemove(page: const MainPage());
                          },
                          icon: Icons.logout_rounded)
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: DecoratedContainer(
                            backColor: AppColors.kBlackLightColor,
                            child: activePage),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  List<MenuModel> menus = [
    MenuModel(title: "Realisations", page: const PublicationForm()),
    MenuModel(title: "Videos", page: const VideoImportWidget()),
  ];
}
