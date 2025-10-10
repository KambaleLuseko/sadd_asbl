import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadd_asbl/Resources/Components/button.dart';
import 'package:sadd_asbl/Resources/Components/text_fields.dart';
import 'package:sadd_asbl/Resources/Components/texts.dart';
import 'package:sadd_asbl/Resources/Constants/global_variables.dart';
import 'package:sadd_asbl/Views/Admin/controller/admin.provider.dart';
import 'package:sadd_asbl/Views/News/controller/news.provider.dart';

class VideoImportWidget extends StatefulWidget {
  const VideoImportWidget({super.key});

  @override
  State<VideoImportWidget> createState() => _VideoImportWidgetState();
}

class _VideoImportWidgetState extends State<VideoImportWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _auteurController.text = context.read<AdminProvider>().user?.email ?? '';
      setState(() {});
    });
  }

  // Clé globale pour le formulaire
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs pour les champs de texte
  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _auteurController = TextEditingController();
  final TextEditingController _contenuController = TextEditingController();
  final TextEditingController _videoController = TextEditingController();

  // Fonction de soumission du formulaire
  void _submitForm() {
    // Vérifie si la validation est passée
    if (_formKey.currentState!.validate()) {
      // Vérifie si une date a été sélectionnée

      // Les données sont cohérentes, on peut les envoyer au backend
      final Map<String, dynamic> data = {
        'titre': _titreController.text.trim(),
        'auteur': _auteurController.text.trim(),
        'description': _descriptionController.text.trim(),
        'contenu2': _videoController.text.trim(),
        'contenu1': _contenuController.text,
      };
      // print(data);
      // return;
      context.read<NewsProvider>().saveVideo(data: data, callback: () {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextWidgets.textBold(
                title: "Nouvelle publication",
                fontSize: 22,
                textColor: AppColors.kWhiteColor),
            const SizedBox(height: 32),
            TextFormFieldWidget(
              hintText: 'Titre',
              textColor: AppColors.kWhiteColor,
              backColor: AppColors.kTextFormWhiteColor,
              editCtrller: _titreController,
            ),

            const SizedBox(height: 16),

            // Champ pour l'auteur
            TextFormFieldWidget(
              editCtrller: _descriptionController,
              hintText: 'Description',
              backColor: AppColors.kTextFormWhiteColor,
              textColor: AppColors.kWhiteColor,
            ),
            TextFormFieldWidget(
              editCtrller: _auteurController,
              hintText: 'Auteur',
              backColor: AppColors.kTextFormWhiteColor,
              textColor: AppColors.kWhiteColor,
            ),
            const SizedBox(height: 20),

            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: TextFormFieldWidget(
                  maxLines: 3,
                  hintText: "Video url",
                  textColor: AppColors.kWhiteColor,
                  backColor: AppColors.kTextFormWhiteColor,
                  editCtrller: _contenuController,
                )),
                Expanded(
                    child: TextFormFieldWidget(
                  maxLines: 3,
                  hintText: "Video name",
                  textColor: AppColors.kWhiteColor,
                  backColor: AppColors.kTextFormWhiteColor,
                  editCtrller: _videoController,
                )),
              ],
            ),
            const SizedBox(height: 20),

            Center(
              child: CustomButton(
                  canSync: true,
                  text: "Enregistrer",
                  backColor: AppColors.kSecondaryColor,
                  textColor: AppColors.kWhiteColor,
                  callback: () {
                    _submitForm();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
