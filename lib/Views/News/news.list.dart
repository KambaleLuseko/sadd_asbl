import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Resources/Components/dialogs.dart';
import '../../Resources/Components/texts.dart';
import '../../Resources/Constants/global_variables.dart';
import '../../Resources/Constants/responsive.dart';
import '../../Resources/Helpers/date_parser.dart';
import '../../Widgets/footer.widget.dart';
import 'controller/news.provider.dart';
import 'model/news.model.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextWidgets.textBold(
              title: "Réalisations",
              fontSize: 32,
              textColor: AppColors.kWhiteColor,
            ),
            // IconButtonWidget(
            //     backColor: AppColors.kGreenColor,
            //     textColor: AppColors.kWhiteColor,
            //     callback: () {
            //       Dialogs.showModal(
            //           hasScroll: true, child: const PublicationForm());
            //     },
            //     icon: Icons.add),
          ],
        ),
        // TextWidgets.text300(
        //   maxLines: 5,
        //   title:
        //       "Depuis la creation de la societe cooperative, nous avons effectues plusieurs activites, notamment des visites des sponsors et dignitaires etrangers afin d'ameliorer nos services et nos produits.",
        //   fontSize: 16,
        //   textColor: AppColors.kWhiteColor,
        // ),
        const SizedBox(height: 32),
        Selector<NewsProvider, List<NewsModel>>(
            builder: (_, data, __) {
              return GridView.count(
                crossAxisCount: Responsive.isMobile(context) ? 1 : 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                shrinkWrap: true,
                childAspectRatio: 1.5,
                children: [
                  ...List.generate(data.length, (index) {
                    return NewsItemWidget(data: data[index]);
                  }),
                ],
              );
            },
            selector: (_, provider) => provider.displayedData),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  context.read<NewsProvider>().changePage(action: 'previous');
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.kWhiteColor,
                )),
            TextWidgets.text300(
                title:
                    "${context.select<NewsProvider, int>((value) => value.currentPage).toString()}/${context.read<NewsProvider>().pageCount}",
                fontSize: 24,
                textColor: AppColors.kWhiteColor),
            IconButton(
                onPressed: () {
                  context.read<NewsProvider>().changePage(action: 'next');
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.kWhiteColor,
                )),
          ],
        ),
        const FooterComponentWidget(),
      ],
    );
  }
}

class NewsItemWidget extends StatelessWidget {
  const NewsItemWidget({super.key, required this.data});
  final NewsModel data;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Dialogs.showModal(
          // hasAppBar: false,
          hasScroll: true,
          child: NewsDetailsPage(data: data),
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                // color: AppColors.kTextFormWhiteColor,
                // boxShadow: const [
                //   BoxShadow(
                //     blurRadius: 4,
                //     color: Color(0x230E151B),
                //     offset: Offset(0.0, 2),
                //   ),
                // ],
                // borderRadius: BorderRadius.circular(12),
                ),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: CachedNetworkImage(
                        fadeInCurve: Curves.easeIn,
                        fadeOutCurve: Curves.easeOut,
                        fadeInDuration: const Duration(milliseconds: 500),
                        fadeOutDuration: const Duration(milliseconds: 500),
                        width: double.maxFinite,
                        height: double.maxFinite,
                        fit: BoxFit.cover,
                        imageUrl: '${BaseUrl.apiUrl}/images/${data.image}',
                        errorWidget: (context, url, error) => Icon(
                          Icons.image,
                          color: AppColors.kWhiteColor,
                        ),
                      )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: TextWidgets.textBold(
                            maxLines: 3,
                            title: data.contenu
                                .toString()
                                .replaceAll('-', ' ')
                                .toUpperCase(),
                            fontSize: 16,
                            textColor: AppColors.kWhiteColor,
                          )),
                          const SizedBox(
                            width: 16,
                          ),
                          TextWidgets.text300(
                            title: "${data.viewCount ?? 0} Vues",
                            fontSize: 12,
                            textColor: AppColors.kWhiteColor,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidgets.text300(
                            title:
                                "${parseDate(date: data.datePub ?? '')}, ${data.viewCount ?? 0} Vues",
                            fontSize: 12,
                            textColor: AppColors.kWhiteDarkColor,
                          ),
                          TextWidgets.textNormal(
                            title: data.auteur?.toUpperCase() ?? '',
                            fontSize: 12,
                            textColor: AppColors.kYellowColor,
                          ),
                          // Padding(
                          //   padding: const EdgeInsetsDirectional.fromSTEB(
                          //       0, 0, 0, 0),
                          //   child: TextWidgets.textNormal(
                          //     title: "${data['count']} photos",
                          //     fontSize: 16,
                          //     textColor: AppColors.kWhiteColor.withAlpha(80),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewsDetailsPage extends StatefulWidget {
  const NewsDetailsPage({super.key, required this.data});
  final NewsModel data;
  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      activeImage = widget.data.image ?? '';
      setState(() {});
      context.read<NewsProvider>().saveViews(newsID: widget.data.id!);
    });
  }

  String activeImage = '';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: TextWidgets.textBold(
              align: TextAlign.center,
              maxLines: 5,
              title: widget.data.contenu
                      ?.toString()
                      .replaceAll('-', ' ')
                      .toUpperCase() ??
                  '',
              fontSize: 32,
              textColor: AppColors.kWhiteColor,
            ),
          ),
          // TextWidgets.textBold(
          //   title: widget.data['name']
          //       .toString()
          //       .replaceAll('-', ' ')
          //       .toUpperCase(),
          //   fontSize: 32,
          //   textColor: AppColors.kWhiteColor,
          // ),
          if (activeImage.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Container(
                // height: 300,
                constraints: const BoxConstraints(maxHeight: 500),
                padding: EdgeInsets.zero,
                child: ClipRRect(
                    child: CachedNetworkImage(
                  fadeInCurve: Curves.easeIn,
                  fadeOutCurve: Curves.easeOut,
                  fadeInDuration: const Duration(milliseconds: 500),
                  fadeOutDuration: const Duration(milliseconds: 500),
                  // width: double.maxFinite,
                  // height: double.maxFinite,
                  // fit: BoxFit.cover,
                  imageUrl: '${BaseUrl.apiUrl}/images/$activeImage',
                  errorWidget: (context, url, error) => Icon(
                    Icons.image,
                    color: AppColors.kWhiteColor,
                  ),
                )),
              ),
            ),
          const SizedBox(height: 32),
          Container(
            alignment: Alignment.centerLeft,
            height: 100,
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...List.generate(
                      [
                        widget.data.image!,
                        widget.data.image2!,
                      ].length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          activeImage = [
                            widget.data.image!,
                            widget.data.image2!,
                          ][index];
                        });
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: activeImage == index
                                  ? AppColors.kWhiteColor
                                  : AppColors.kTransparentColor,
                              width: 4,
                            ),
                          ),
                          child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
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
                                imageUrl: '${BaseUrl.apiUrl}/images/${[
                                  widget.data.image!,
                                  widget.data.image2!,
                                ][index]}',
                                errorWidget: (context, url, error) => Icon(
                                  Icons.image,
                                  color: AppColors.kWhiteColor,
                                ),
                              )),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          // const SizedBox(height: 32),
          // // TextWidgets.textBold(
          // //   title:
          // //       "Titre Principal de l'Actualité : Innovation Majeure Révélée dans le Secteur Technologique Local",
          // //   fontSize: 24,
          // //   textColor: AppColors.kWhiteColor,
          // // ),
          // const SizedBox(height: 16),
          TextWidgets.textBold(
            title:
                "Date de publication: ${parseDate(date: widget.data.datePub ?? '')}",
            fontSize: 16,
            textColor: AppColors.kWhiteColor,
          ),
          const SizedBox(height: 32),
          //     TextWidgets.text300(
          //       align: TextAlign.justify,
          //       maxLines: 300,
          //       title: """
          // Goma, RDC – Une annonce capitale a secoué le monde de la technologie cette semaine, avec la révélation d'une innovation révolutionnaire qui promet de redéfinir les standards actuels. Les détails, encore parcimonieux, suggèrent une avancée significative ayant le potentiel d'impacter plusieurs industries clés, de l'énergie à la communication. Les experts anticipent déjà un changement de paradigme dans la manière dont certaines opérations sont menées à l'échelle régionale.

          // Les premières démonstrations à huis clos, selon des sources proches du dossier, ont laissé les observateurs stupéfaits par l'efficacité et la simplicité du nouveau procédé. L'équipe derrière cette découverte, un collectif de chercheurs locaux et d'ingénieurs talentueux, a travaillé dans le plus grand secret pendant plusieurs années, soulignant l'importance de la confidentialité dans ce domaine de haute technologie. Leur persévérance et leur vision semblent aujourd'hui porter leurs fruits, plaçant Goma au centre de l'attention technologique.

          // Impact Potentiel sur l l'Économie Locale et Régionale
          // Au-delà de l'aspect purement technique, les implications économiques de cette innovation sont considérables. Les analystes prévoient une création significative d'emplois, une augmentation des investissements étrangers et un renforcement de la position du Nord-Kivu comme hub d'innovation en Afrique centrale. Des discussions préliminaires avec des partenaires internationaux auraient déjà commencé, laissant entrevoir des collaborations fructueuses à l'horizon. Les retombées pourraient s'étendre aux infrastructures locales et à la formation de nouvelles générations de professionnels.

          // Cependant, des défis subsistent, notamment en matière de régulation et de déploiement à grande échelle. La phase suivante consistera à obtenir les certifications nécessaires et à établir des partenariats stratégiques pour garantir une adoption rapide et efficace. La communauté attend avec impatience la publication officielle des spécifications techniques complètes, prévue pour le début du prochain trimestre.

          // Cette percée technologique confirme une fois de plus le dynamisme et le potentiel d'innovation qui émanent de la région, ouvrant la voie à un avenir prometteur.
          // """,
          //       fontSize: 16,
          //       textColor: AppColors.kWhiteDarkColor,
          //     ),
        ],
      ),
    );
  }
}
