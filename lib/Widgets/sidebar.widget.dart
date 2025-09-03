import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Resources/Components/texts.dart';
import '../Resources/Constants/global_variables.dart';
import '../Resources/Models/Menu/menu.model.dart';
import '../Resources/Providers/menu_provider.dart';
import '../Views/About/about.page.dart';
import '../Views/Galery/goals.dart';
import '../Views/Home/home.page.dart';
import '../Views/News/news.page.dart';

class SidebarNavbarWidget extends StatefulWidget {
  const SidebarNavbarWidget({super.key});

  @override
  State<SidebarNavbarWidget> createState() => _SidebarNavbarWidgetState();
}

class _SidebarNavbarWidgetState extends State<SidebarNavbarWidget> {
  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.kAccentColor),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(24, 54, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                'Assets/Icons/logo-yellow.png',
                width: 32,
                height: 32,
                fit: BoxFit.contain,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    context.read<MenuProvider>().setActivePage(
                          newPage: MenuModel(
                              title: "Accueil", page: const HomePage()),
                        );
                  },
                  child: TextWidgets.text300(
                    title: "Accueil",
                    fontSize: 14,
                    textColor: AppColors.kWhiteColor,
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    context.read<MenuProvider>().setActivePage(
                          newPage: MenuModel(
                            title: "A propos",
                            page: const AboutPageWidget(),
                          ),
                        );
                  },
                  child: TextWidgets.text300(
                    title: "A propos",
                    fontSize: 14,
                    textColor: AppColors.kWhiteColor,
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    context.read<MenuProvider>().setActivePage(
                          newPage: MenuModel(
                              title: "Nos objectifs", page: const GoalsPage()),
                        );
                  },
                  child: TextWidgets.text300(
                    title: "Nos objectifs",
                    fontSize: 14,
                    textColor: AppColors.kWhiteColor,
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    context.read<MenuProvider>().setActivePage(
                          newPage: MenuModel(
                              title: "Réalisations", page: const NewsPage()),
                        );
                  },
                  child: TextWidgets.text300(
                    title: "Réalisations",
                    fontSize: 14,
                    textColor: AppColors.kWhiteColor,
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {},
                  child: Container(
                    width: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.kSecondaryColor,
                          AppColors.kSecondaryColor,
                        ],
                        stops: const [0, 1],
                        begin: const AlignmentDirectional(-1, -1),
                        end: const AlignmentDirectional(1, 1),
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
                        child: TextWidgets.text300(
                          title: "Get in touch",
                          fontSize: 14,
                          textColor: AppColors.kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
