import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sadd_asbl/Resources/Components/button.dart';
import 'package:sadd_asbl/Resources/Constants/navigators.dart';
import 'package:sadd_asbl/Views/Admin/login.page.dart';

import '../Resources/Components/texts.dart';
import '../Resources/Constants/global_variables.dart';
import '../Resources/Constants/responsive.dart';
import '../Resources/Models/Menu/menu.model.dart';
import '../Resources/Providers/menu_provider.dart';
import '../Views/About/about.page.dart';
import '../Views/Galery/goals.dart';
import '../Views/Home/home.page.dart';
import '../Views/News/news.page.dart';
import '../main.dart';
import 'social_link.widget.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({super.key, required this.drawerCallback});

  final Future Function()? drawerCallback;

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(color: AppColors.kScaffoldColor),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {},
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (Responsive.isMobile(context))
                        IconButton(
                          icon: Icon(
                            Icons.menu_rounded,
                            color: AppColors.kWhiteColor,
                            size: 32,
                          ),
                          onPressed: () async {
                            await widget.drawerCallback?.call();
                          },
                        ),
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(24),
                      //   child: Image.asset(
                      //     'Assets/Icons/logo-yellow.png',
                      //     width: 32,
                      //     height: 32,
                      //     fit: BoxFit.contain,
                      //   ),
                      // ),
                      const SizedBox(
                        width: 16,
                      ),
                      TextWidgets.textBold(
                        title: appName,
                        fontSize: 32,
                        textColor: AppColors.kWhiteColor,
                      ),
                    ],
                  ),
                ),
                if (Responsive.isMobile(context) == false)
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.read<MenuProvider>().setActivePage(
                                  newPage: MenuModel(
                                    title: "Accueil",
                                    page: const HomePage(),
                                  ),
                                );
                          },
                          child: TextWidgets.textBold(
                            title: "Accueil",
                            fontSize: 14,
                            textColor: AppColors.kWhiteColor,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
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
                          child: TextWidgets.textBold(
                            title: "A propos",
                            fontSize: 14,
                            textColor: AppColors.kWhiteColor,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.read<MenuProvider>().setActivePage(
                                  newPage: MenuModel(
                                    title: "Nos objectifs",
                                    page: const GoalsPage(),
                                  ),
                                );
                          },
                          child: TextWidgets.textBold(
                            title: "Nos objectifs",
                            fontSize: 14,
                            textColor: AppColors.kWhiteColor,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.read<MenuProvider>().setActivePage(
                                  newPage: MenuModel(
                                    title: "Réalisations",
                                    page: const NewsPage(),
                                  ),
                                );
                          },
                          child: TextWidgets.textBold(
                            title: "Réalisations",
                            fontSize: 14,
                            textColor: AppColors.kWhiteColor,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ),
                const SizedBox(
                  width: 24,
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SocialLinkWidget(
                      // iconColor: Colors.blue.shade700,
                      icon: FontAwesomeIcons.facebook,
                      // iconColor: Colors.blue,
                      link: 'https://www.facebook.com/',
                      title: "Facebook",
                      fontSize: 16,
                    ),
                    SizedBox(height: 8),
                    SocialLinkWidget(
                      icon: FontAwesomeIcons.youtube,
                      // iconColor: Colors.red,
                      link: 'https://www.youtube.com/@saddasbl1190',
                      fontSize: 20,
                      title: "Youtube",
                    ),
                    SizedBox(height: 8),
                    SocialLinkWidget(
                      // iconColor: Colors.pinkAccent.shade700,
                      icon: FontAwesomeIcons.instagram,
                      link: 'https://www.instagram.com/',
                      fontSize: 20,
                      title: "Instagram",
                    ),
                  ],
                ),
                // if (Responsive.isMobile(context) == false)
                //   Padding(
                //     padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 24, 0),
                //     child: InkWell(
                //       splashColor: Colors.transparent,
                //       focusColor: Colors.transparent,
                //       hoverColor: Colors.transparent,
                //       highlightColor: Colors.transparent,
                //       onTap: () async {},
                //       child: Container(
                //         decoration: BoxDecoration(
                //           color: AppColors.kSecondaryColor,
                //           borderRadius: BorderRadius.circular(50),
                //         ),
                //         child: Align(
                //           alignment: const AlignmentDirectional(0, 0),
                //           child: Padding(
                //             padding: const EdgeInsetsDirectional.fromSTEB(
                //               12,
                //               6,
                //               12,
                //               6,
                //             ),
                //             child: TextWidgets.text300(
                //               title: "Get in touch",
                //               fontSize: 14,
                //               textColor: AppColors.kBlackColor,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                IconButtonWidget(
                    backColor: AppColors.kTransparentColor,
                    textColor: AppColors.kWhiteColor,
                    callback: () {
                      Navigation.pushReplaceNavigate(page: const LoginPage());
                    },
                    icon: Icons.login_rounded)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
