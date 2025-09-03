import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadd_asbl/Resources/Providers/users_provider.dart';
import 'package:sadd_asbl/Views/News/controller/news.provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Resources/Providers/app_state_provider.dart';
import 'Resources/Providers/menu_provider.dart';
import 'Views/main.page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

ValueKey key = ValueKey(DateTime.now().toString());

late SharedPreferences prefs;

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
String appName = "SADD ASBL";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        scrollbars: true,
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
        },
      ),
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          ),
      navigatorKey: navKey,
      home: const MainPage(),
    );
  }
}

List<String> storeNames = [];
