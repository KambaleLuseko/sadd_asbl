import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Resources/Components/texts.dart';
import '../Resources/Constants/global_variables.dart';
import '../Resources/Models/Menu/menu.model.dart';
import '../Resources/Providers/app_state_provider.dart';
import '../Resources/Providers/menu_provider.dart';
import '../Resources/Providers/users_provider.dart';
import '../main.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.kAccentColor,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Consumer<MenuProvider>(
          builder: (context, menuStateProvider, child) {
            return Column(
              children: [
                Card(
                  margin: const EdgeInsets.all(0),
                  color: AppColors.kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Center(
                          child: Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              border: Border.all(
                                color: AppColors.kWhiteColor,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: AppColors.kWhiteColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: TextWidgets.textBold(
                                  title: context
                                          .watch<UserProvider>()
                                          .userLogged
                                          ?.user
                                          .fullname ??
                                      appName.toUpperCase(),
                                  fontSize: 16,
                                  textColor: AppColors.kWhiteColor,
                                ),
                              ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              Container(
                                child: TextWidgets.text300(
                                  title: context
                                          .watch<UserProvider>()
                                          .userLogged
                                          ?.user
                                          .phoneNumber ??
                                      'contact@${appName.toLowerCase().replaceAll(' ', '')}.com',
                                  fontSize: 12,
                                  textColor: AppColors.kGreyColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                child: TextWidgets.text300(
                                  title: context
                                          .watch<UserProvider>()
                                          .userLogged
                                          ?.user
                                          .niveau ??
                                      'Unknown',
                                  fontSize: 12,
                                  textColor: AppColors.kWhiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(color: AppColors.kScaffoldColor),
                //   alignment: Alignment.center,
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       InkWell(
                //         onTap: () {},
                //         child: IconStateItem(
                //           icon: Icons.shopping_cart_rounded,
                //           validState: true,
                //         ),
                //       ),
                //       IconStateItem(
                //         icon: Icons.notifications_active,
                //         validState: false,
                //         errorIcon: Text(
                //           '0'.padLeft(2, '0'),
                //           style: TextStyle(
                //               fontSize: 6, color: AppColors.kWhiteColor),
                //         ),
                //       ),
                //       IconStateItem(
                //         icon: Icons.wifi,
                //         validState:
                //             context.watch<AppStateProvider>().isApiReachable,
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(height: 8),
                Expanded(
                  child: ListView(
                    controller: ScrollController(keepScrollOffset: false),
                    children: [
                      ...List.generate(menuStateProvider.menus.length, (index) {
                        return MenuItem(
                          menu: menuStateProvider.menus[index],
                          textColor: AppColors.kWhiteColor,
                          hoverColor: AppColors.kWhiteColor.withOpacity(0.7),
                          backColor: AppColors.kAccentColor,
                        );
                      }),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     children: [
                //       ChipFilter.roundedChipFilter(
                //           backColor: AppColors.kScaffoldColor,
                //           textColor: AppColors.kWhiteColor,
                //           title: 'Fr',
                //           active: context
                //               .watch<AppStateProvider>()
                //               .currentLanguage
                //               ?.languageCode
                //               .toLowerCase(),
                //           callback: () {
                //             context
                //                 .read<AppStateProvider>()
                //                 .changeLanguage(languageCode: 'fr');
                //             context.setLocale(context
                //                 .read<AppStateProvider>()
                //                 .currentLanguage!);
                //             setState(() {});
                //           }),
                //       ChipFilter.roundedChipFilter(
                //           backColor: AppColors.kScaffoldColor,
                //           textColor: AppColors.kWhiteColor,
                //           title: 'En',
                //           active: context
                //               .watch<AppStateProvider>()
                //               .currentLanguage
                //               ?.languageCode
                //               .toLowerCase(),
                //           callback: () {
                //             context
                //                 .read<AppStateProvider>()
                //                 .changeLanguage(languageCode: 'en');
                //             context.setLocale(context
                //                 .read<AppStateProvider>()
                //                 .currentLanguage!);
                //             setState(() {});
                //           }),
                //     ],
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class IconStateItem extends StatelessWidget {
  final bool validState;
  final IconData icon;
  final Widget? errorIcon;
  final Color? iconColor;

  const IconStateItem({
    super.key,
    required this.icon,
    this.errorIcon,
    this.validState = true,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(icon, color: iconColor, size: 30),
        ),
        if (validState == false)
          Positioned(
            top: 0,
            right: 0,
            child: Card(
              color: AppColors.kRedColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              margin: const EdgeInsets.all(0),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: errorIcon ??
                    Icon(
                      Icons.warning_amber_rounded,
                      color: AppColors.kWhiteColor,
                      size: 12,
                    ),
              ),
            ),
          ),
      ],
    );
  }
}

class MenuItem extends StatefulWidget {
  final MenuModel menu;
  final Color textColor;
  final Color hoverColor;
  final Color backColor;

  const MenuItem({
    super.key,
    required this.menu,
    required this.backColor,
    required this.hoverColor,
    required this.textColor,
  });

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool isButtonHovered = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(
      builder: (context, menuStateProvider, child) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
            if (menuStateProvider.getActivePage()?.title == widget.menu.title) {
              return;
            }
            menuStateProvider.setActivePage(newPage: widget.menu);
          },
          child: MouseRegion(
            // cursor: MouseCursor.,
            onHover: (value) => setState(() {
              isButtonHovered = true;
            }),
            onEnter: (value) => setState(() {
              isButtonHovered = true;
            }),
            onExit: (value) => setState(() {
              isButtonHovered = false;
            }),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              margin: const EdgeInsets.only(left: 8, top: 0, bottom: 0),
              decoration: BoxDecoration(
                color: menuStateProvider.activePage.title == widget.menu.title
                    ? widget.textColor.withOpacity(0.05)
                    : widget.backColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  topLeft: Radius.circular(16),
                ),
              ),
              // menuStateProvider.currentMenu == widget.title || isButtonHovered
              //     ? widget.textColor
              //     : widget.backColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Icon(
                                widget.menu.icon,
                                color: menuStateProvider.activePage.title ==
                                            widget.menu.title ||
                                        isButtonHovered
                                    ? widget.hoverColor
                                    : widget.textColor,
                              ),
                              const SizedBox(width: 16.0),
                              Container(
                                padding: EdgeInsets.zero,
                                child: Text(
                                  widget
                                          .menu
                                          .languagesTitle?[context
                                              .read<AppStateProvider>()
                                              .currentLanguage
                                              ?.languageCode]
                                          ?.toString() ??
                                      widget.menu.title,
                                  style: TextStyle(
                                    color: menuStateProvider.activePage.title ==
                                                widget.menu.title ||
                                            isButtonHovered
                                        ? widget.hoverColor
                                        : widget.textColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 5,
                        height: 40,
                        decoration: BoxDecoration(
                          color: menuStateProvider.activePage.title ==
                                  widget.menu.title
                              ? AppColors.kWhiteColor.withOpacity(1)
                              : widget.backColor,
                          // borderRadius: const BorderRadius.only(
                          //     topRight: Radius.circular(16),
                          //     bottomRight: Radius.circular(10)),
                        ),
                      ),
                    ],
                  ),
                  // !Responsive.isWeb(context)
                  //     ? const Divider(
                  //         height: 2,
                  //         color: Colors.black45,
                  //         thickness: 1,
                  //       )
                  //     : Container()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
