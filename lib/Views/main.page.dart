import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadd_asbl/Resources/Components/texts.dart';
import 'package:sadd_asbl/Resources/Providers/app_state_provider.dart';

import '../Resources/Constants/global_variables.dart';
import '../Resources/Constants/responsive.dart';
import '../Resources/Providers/menu_provider.dart';
import '../Widgets/navbar.widget.dart';
import 'Home/widgets/caroussel.widget.dart';
import 'News/controller/news.provider.dart';
import 'menu.widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<MenuProvider>().initDefaultMenu();
      context.read<NewsProvider>().get();
      context.read<NewsProvider>().getVideo();
      await context.read<AppStateProvider>().getStats();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      drawerScrimColor: AppColors.kPrimaryColor.withOpacity(0.1),
      backgroundColor: AppColors.kPrimaryColor,
      key: _scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: const Drawer(elevation: 1, child: MenuWidget()),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 88,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: double.maxFinite,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.kPrimaryColor, AppColors.kPrimaryColor],
                    stops: const [0, 1],
                    begin: const AlignmentDirectional(-0.94, 1),
                    end: const AlignmentDirectional(0.94, -1),
                  ),
                ),
                child: ListView(
                  children: [
                    if (context
                            .watch<MenuProvider>()
                            .activePage
                            .title
                            .toLowerCase() ==
                        'accueil')
                      const CarousselWidget(),
                    ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          width: Responsive.isMobile(context)
                              ? 500
                              : Responsive.isTablet(context)
                                  ? 800
                                  : 1200,
                          child: context.watch<MenuProvider>().activePage.page,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // if (!Responsive.isWeb(context))
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: NavbarWidget(
                drawerCallback: () async {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                      color: AppColors.kWhiteColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16))),
                  child: Row(
                    children: [
                      TextWidgets.textBold(
                          title: context
                              .select<AppStateProvider, Map>(
                                  (value) => value.stats)['visits']
                              .toString(),
                          fontSize: 12,
                          textColor: AppColors.kBlackColor),
                      TextWidgets.textNormal(
                          title: " visites",
                          fontSize: 12,
                          textColor: AppColors.kBlackColor),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
