import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Resources/Components/texts.dart';
import '../Resources/Constants/global_variables.dart';
import '../Resources/Constants/responsive.dart';
import '../Resources/Helpers/date_parser.dart';
import '../Views/News/controller/news.provider.dart';
import '../Views/News/model/news.model.dart';
import '../main.dart';

class WhyUsComponentWidget extends StatefulWidget {
  const WhyUsComponentWidget({super.key});

  @override
  State<WhyUsComponentWidget> createState() => _WhyUsComponentWidgetState();
}

class _WhyUsComponentWidgetState extends State<WhyUsComponentWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initData();
    });
  }

  initData() {
    if (context.read<NewsProvider>().offlineData.isEmpty) return;
    data = [
      ...List.generate(4, (i) {
        int index = Random().nextInt(
            navKey.currentContext!.read<NewsProvider>().offlineData.length);
        // print(index);
        return SocialImpactModel(
          title: navKey.currentContext!
                  .read<NewsProvider>()
                  .offlineData[index]
                  .contenu ??
              '',
          subtitle:
              "Publié le ${parseDate(date: navKey.currentContext!.read<NewsProvider>().offlineData[index].datePub ?? '')}",
          imagePath: navKey.currentContext!
                  .read<NewsProvider>()
                  .offlineData[index]
                  .image ??
              '',
        );
      })
    ];
    if (mounted) {
      // setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<NewsProvider, List<NewsModel>>(
        selector: (_, provider) => provider.offlineData,
        builder: (_, offlineData, __) {
          initData();
          return Container(
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: TextWidgets.textBold(
                    title: 'NOS ACTIONS',
                    fontSize: () {
                      if (Responsive.isMobile(context)) {
                        return 32.0;
                      } else {
                        return 48.0;
                      }
                    }(),
                    textColor: AppColors.kWhiteColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                  child: GridView(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: () {
                        if (Responsive.isMobile(context)) {
                          return 1;
                        } else if (Responsive.isTablet(context)) {
                          return 2;
                        } else if (Responsive.isWeb(context)) {
                          return 2;
                        } else {
                          return 2;
                        }
                      }(),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: () {
                        if (Responsive.isMobile(context)) {
                          return 1.0;
                        } else if (Responsive.isTablet(context)) {
                          return 1.0;
                        } else if (Responsive.isWeb(context)) {
                          return 1.5;
                        } else {
                          return 1.5;
                        }
                      }(),
                    ),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      ...List.generate(data.length, (index) {
                        return SocialImpactItem(data: data[index]);
                      }),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  List<SocialImpactModel> data = [];
}

class SocialImpactItem extends StatelessWidget {
  const SocialImpactItem({super.key, required this.data});
  final SocialImpactModel data;
  @override
  Widget build(BuildContext context) {
    return Stack(
      // mainAxisSize: MainAxisSize.max,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            fadeInCurve: Curves.easeIn,
            fadeOutCurve: Curves.easeOut,
            fadeInDuration: const Duration(milliseconds: 500),
            fadeOutDuration: const Duration(milliseconds: 500),
            width: double.maxFinite,
            height: double.maxFinite,
            fit: BoxFit.cover,
            imageUrl: '${BaseUrl.apiUrl}/images/${data.imagePath}',
            errorWidget: (context, url, error) => Icon(
              Icons.image,
              color: AppColors.kWhiteColor,
            ),
          ),
        ),
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const [0, 0.5],
              colors: [Colors.black.withAlpha(255), Colors.black.withAlpha(48)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextWidgets.textBold(
                  maxLines: 3,
                  title: data.title,
                  fontSize: 14,
                  textColor: AppColors.kWhiteColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextWidgets.text300(
                  align: TextAlign.center,
                  maxLines: 5,
                  title: data.subtitle,
                  fontSize: 14,
                  textColor: AppColors.kWhiteColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SocialImpactModel {
  final String title, subtitle, imagePath;

  SocialImpactModel({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
}
