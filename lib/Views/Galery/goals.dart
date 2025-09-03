import 'package:flutter/material.dart';

import '../../Resources/Components/texts.dart';
import '../../Resources/Constants/global_variables.dart';
import '../../Widgets/footer.widget.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        TextWidgets.textBold(
          title: "Nos objectifs",
          fontSize: 32,
          textColor: AppColors.kWhiteColor,
        ),
        const SizedBox(height: 32),
        TextWidgets.text300(
          maxLines: 5,
          title:
              "La Solidaire Action pour le Droit et le Développement poursuit comme objectif global : « la protection des droits humains et la promotion du développement ». Comme objectifs spécifiques, la SADD Asbl a pour objectifs :",
          fontSize: 16,
          textColor: AppColors.kWhiteColor,
        ),
        Container(
          padding: const EdgeInsets.only(left: 48, top: 24),
          child: TextWidgets.text300(
              maxLines: 1200,
              title: """
✔️ L’assistance juridico-judiciaire aux indigents, aux torturés, aux personnes arrêtés arbitrairement ;
✔️ La défense des droits de la femme et de l’enfant ;
✔️ La protection des personnes vivant avec VIH/SIDA et personne vivant avec handicape
✔️Protection de l’environnement et arbitrage en matière de conflits fonciers,
✔️ Protection du consommateur,
✔️ Lutte contre la torture et traitement inhumain et dégradant,
✔️ Renforcement des capacités des animateurs et intervenant dans la chaine judiciaire et plus particulièrement les agents des services pénitentiaires,
✔️ Encadrement et appui aux acteurs locaux de développement ;
✔️ Lutte contre l’impunité et les violences sexuelles,
✔️ Prise en charge psycho-sociale (trauma-counselling) ;
✔️ Réinsertion sociale des personnes vulnérables et détenus.
""",
              fontSize: 16,
              textColor: AppColors.kWhiteColor),
        ),
        const FooterComponentWidget(),
      ],
    );
  }
}

class GaleryItem extends StatefulWidget {
  const GaleryItem({super.key, required this.data});
  final Map data;

  @override
  State<GaleryItem> createState() => _GaleryItemState();
}

class _GaleryItemState extends State<GaleryItem> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(color: AppColors.kAccentColor),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  widget.data['content'].first,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextWidgets.textBold(
                      title: widget.data['name']
                          .toString()
                          .replaceAll('-', ' ')
                          .toUpperCase(),
                      fontSize: 18,
                      textColor: AppColors.kWhiteColor,
                    ),
                  ),
                  TextWidgets.text300(
                    title: "${widget.data['count']} photos",
                    fontSize: 18,
                    textColor: AppColors.kWhiteColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Map> data = [
  {"name": "belgique", "count": 3},
  {"name": "cafe-idjwi", "count": 2},
  {"name": "cafe-plus", "count": 3},
  {"name": "cpnck-2022", "count": 2},
  {"name": "guillaume", "count": 2},
  {"name": "inaug", "count": 2},
  {"name": "masisi", "count": 2},
  {"name": "remise-dip", "count": 2},
  {"name": "usadf", "count": 3},
];

List<Map> dataContent = [
  {
    "name": "belgique",
    "count": 3,
    "content": [
      "Assets/Galerie/belgique-1.jpg",
      "Assets/Galerie/belgique-2.jpg",
      "Assets/Galerie/belgique-3.jpg",
    ],
  },
  {
    "name": "cafe-idjwi",
    "count": 2,
    "content": [
      "Assets/Galerie/cafe-idjwi-1.JPG",
      "Assets/Galerie/cafe-idjwi-2.JPG",
    ],
  },
  {
    "name": "cafe-plus",
    "count": 3,
    "content": [
      "Assets/Galerie/cafe-plus-1.JPG",
      "Assets/Galerie/cafe-plus-2.JPG",
      "Assets/Galerie/cafe-plus-3.JPG",
    ],
  },
  {
    "name": "cpnck-2022",
    "count": 2,
    "content": [
      "Assets/Galerie/cpnck-2022-1.jpg",
      "Assets/Galerie/cpnck-2022-2.jpg",
    ],
  },
  {
    "name": "guillaume",
    "count": 2,
    "content": [
      "Assets/Galerie/guillaume-1.jpg",
      "Assets/Galerie/guillaume-2.jpg",
    ],
  },
  {
    "name": "inaug",
    "count": 2,
    "content": ["Assets/Galerie/inaug-1.JPG", "Assets/Galerie/inaug-2.JPG"],
  },
  {
    "name": "masisi",
    "count": 2,
    "content": ["Assets/Galerie/masisi-1.jpg", "Assets/Galerie/masisi-2.jpg"],
  },
  {
    "name": "remise-dip",
    "count": 2,
    "content": [
      "Assets/Galerie/remise-dip-1.jpg",
      "Assets/Galerie/remise-dip-2.jpg",
    ],
  },
  {
    "name": "usadf",
    "count": 3,
    "content": [
      "Assets/Galerie/usadf-1.jpg",
      "Assets/Galerie/usadf-2.jpg",
      "Assets/Galerie/usadf-3.jpg",
    ],
  },
];
