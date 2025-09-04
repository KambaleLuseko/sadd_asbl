import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadd_asbl/Resources/Components/dialogs.dart';
import 'package:sadd_asbl/Views/News/news.list.dart';

import '../../../Resources/Components/button.dart';
import '../../../Resources/Components/texts.dart';
import '../../../Resources/Constants/global_variables.dart';
import '../../../Resources/Constants/responsive.dart';
import '../../../Resources/Helpers/date_parser.dart';
import '../../Galery/goals.dart';
import '../../News/controller/news.provider.dart';
import '../../News/model/news.model.dart';

class CarousselWidget extends StatefulWidget {
  const CarousselWidget({super.key});

  @override
  State<CarousselWidget> createState() => _CarousselWidgetState();
}

class _CarousselWidgetState extends State<CarousselWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (context.read<NewsProvider>().carousselData.isEmpty) {
      } else {
        _startAutoSlide();
      }
    });
  }

  void _startAutoSlide() {
    if (_timer != null) {
      return;
    }
    _timer = Timer.periodic(const Duration(seconds: 8), (timer) {
      if (_currentPage < dataContent.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<NewsProvider>().carousselData.isEmpty) {
    } else {
      _startAutoSlide();
    }
    return Column(
      children: [
        Selector<NewsProvider, List<NewsModel>>(
            selector: (_, provider) => provider.carousselData,
            builder: (_, data, __) {
              if (data.isEmpty) {
                return Container(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height - 64,
                  padding: EdgeInsets.zero,
                  color: AppColors.kScaffoldColor,
                );
              }
              return Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height - 64,
                padding: EdgeInsets.zero,
                color: AppColors.kScaffoldColor,
                child: Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 64,
                      child: PageView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              CachedNetworkImage(
                                fadeInCurve: Curves.easeIn,
                                fadeOutCurve: Curves.easeOut,
                                fadeInDuration:
                                    const Duration(milliseconds: 500),
                                fadeOutDuration:
                                    const Duration(milliseconds: 500),
                                width: double.maxFinite,
                                height: double.maxFinite,
                                fit: BoxFit.cover,
                                imageUrl:
                                    '${BaseUrl.apiUrl}/images/${data[index].image}',
                                errorWidget: (context, url, error) => Icon(
                                  Icons.image,
                                  color: AppColors.kWhiteColor,
                                ),
                              ),
                              Positioned(
                                  bottom: 0,
                                  left: 0,
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        // bottom: 32,
                                        right:
                                            Responsive.isWeb(context) == false
                                                ? 0
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                          AppColors.kBlackColor.withAlpha(0),
                                          AppColors.kBlackColor.withAlpha(255)
                                        ])),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: Responsive.isMobile(context)
                                              ? 0
                                              : 88),
                                      padding: const EdgeInsets.all(24.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextWidgets.textBold(
                                              maxLines: 4,
                                              title: data[index].contenu ?? '',
                                              fontSize: 24,
                                              textColor: AppColors.kWhiteColor,
                                            ),
                                            const SizedBox(
                                              height: 24,
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextWidgets.text300(
                                                  maxLines: 4,
                                                  title:
                                                      "Publié le ${parseDate(date: data[index].datePub ?? '').toString().substring(0, 10)},",
                                                  fontSize: 18,
                                                  textColor:
                                                      AppColors.kWhiteColor,
                                                ),
                                                const SizedBox(width: 8),
                                                TextWidgets.textBold(
                                                  maxLines: 4,
                                                  title:
                                                      "${data[index].viewCount ?? 0} vues",
                                                  fontSize: 18,
                                                  textColor:
                                                      AppColors.kWhiteColor,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 24,
                                            ),
                                            CustomButton(
                                                size: 250,
                                                text: "Lire plus",
                                                backColor:
                                                    AppColors.kSecondaryColor,
                                                textColor:
                                                    AppColors.kBlackColor,
                                                callback: () {
                                                  Dialogs.showModal(
                                                    hasScroll: true,
                                                    child: NewsDetailsPage(
                                                        data: data[index]),
                                                  );
                                                })
                                          ]),
                                    ),
                                  ))
                            ],
                          );
                        },
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                      ),
                    ),
                    if (Responsive.isMobile(context) == false)
                      Positioned(
                          left: 24,
                          top: 12,
                          bottom: 64,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 32),
                                width: 3,
                                height: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: AppColors.kSecondaryColor,
                                ),
                              ),
                              ...List.generate(data.length, (index) {
                                return Positioned(
                                    width: 64,
                                    // top: index * 72,
                                    top: ((MediaQuery.of(context).size.height -
                                                64) /
                                            data.length) *
                                        index,
                                    // left: 0,
                                    child: Center(
                                      child: AnimatedContainer(
                                        width: _currentPage == index ? 48 : 32,
                                        height: _currentPage == index ? 48 : 32,
                                        padding: EdgeInsets.all(
                                          _currentPage == index ? 12 : 8,
                                        ),
                                        duration:
                                            const Duration(milliseconds: 1000),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: _currentPage == index
                                                    ? AppColors.kPrimaryColor
                                                    : AppColors
                                                        .kTransparentColor,
                                                width: _currentPage == index
                                                    ? 3
                                                    : 0),
                                            borderRadius:
                                                BorderRadius.circular(120),
                                            color: AppColors.kSecondaryColor),
                                        alignment: Alignment.center,
                                        child: FittedBox(
                                          child: TextWidgets.textBold(
                                              title: (index + 1).toString(),
                                              fontSize: _currentPage == index
                                                  ? 16
                                                  : 14,
                                              textColor: AppColors.kBlackColor),
                                        ),
                                      ),
                                    ));
                              })
                            ],
                          )),
                    if (Responsive.isWeb(context) == true)
                      Positioned(
                        top: 0,
                        right: 0,
                        // left: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 32),
                          alignment: Alignment.bottomCenter,
                          decoration: const BoxDecoration(
                              // color: AppColors.kBlackColor.withAlpha(150),

                              // gradient: LinearGradient(
                              //     begin: Alignment.topCenter,
                              //     end: Alignment.bottomCenter,
                              //     colors: [
                              //   AppColors.kBlackColor.withAlpha(0),
                              //   AppColors.kBlackColor.withAlpha(150)
                              // ])
                              ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ...List.generate(data.length, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    // setState(() {

                                    // });
                                    _currentPage = index;
                                    _pageController.animateToPage(
                                      _currentPage,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 800),
                                    curve: Curves.bounceOut,
                                    margin: const EdgeInsets.all(8),
                                    width: _currentPage == index ? 64 : 40,
                                    height: _currentPage == index ? 72 : 40,
                                    decoration: BoxDecoration(
                                      // image: DecorationImage(
                                      //     image: AssetImage(
                                      //         dataContent[index]['content'][0]),
                                      //     fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(8),
                                      color: index == _currentPage
                                          ? AppColors.kScaffoldColor
                                          : AppColors.kWhiteColor.withAlpha(80),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        fadeInCurve: Curves.easeIn,
                                        fadeOutCurve: Curves.easeOut,
                                        fadeInDuration:
                                            const Duration(milliseconds: 500),
                                        fadeOutDuration:
                                            const Duration(milliseconds: 500),
                                        width: double.maxFinite,
                                        height: double.maxFinite,
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            '${BaseUrl.apiUrl}/images/${data[index].image}',
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                          Icons.image,
                                          color: AppColors.kWhiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}
