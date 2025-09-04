import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadd_asbl/Resources/Components/button.dart';
import 'package:sadd_asbl/Resources/Components/decorated_container.dart';
import 'package:sadd_asbl/Resources/Components/texts.dart';
import 'package:sadd_asbl/Resources/Constants/global_variables.dart';
import 'package:sadd_asbl/Resources/Constants/navigators.dart';
import 'package:sadd_asbl/Resources/Models/Menu/menu.model.dart';
import 'package:sadd_asbl/Views/Admin/controller/admin.provider.dart';
import 'package:sadd_asbl/Views/News/add_news.page.dart';
import 'package:sadd_asbl/Views/main.page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    Widget activePage = menus[0].page;
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
    MenuModel(title: "Videos", page: const PublicationForm()),
  ];
}
