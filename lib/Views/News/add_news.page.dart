import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadd_asbl/Resources/Constants/enums.dart';
import 'package:sadd_asbl/Views/Admin/controller/admin.provider.dart';

import '../../Resources/Components/button.dart';
import '../../Resources/Components/text_fields.dart';
import '../../Resources/Components/texts.dart';
import '../../Resources/Constants/global_variables.dart';
import 'controller/news.provider.dart';
import 'model/news.model.dart';

class PublicationForm extends StatefulWidget {
  const PublicationForm({super.key});

  @override
  State<PublicationForm> createState() => _PublicationFormState();
}

class _PublicationFormState extends State<PublicationForm> {
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
  final TextEditingController _auteurController = TextEditingController();
  final TextEditingController _contenuController = TextEditingController();

  String? _imagePath;
  String? _image2Path;

  // Fonction de soumission du formulaire
  void _submitForm() {
    // Vérifie si la validation est passée
    if (_formKey.currentState!.validate()) {
      // Vérifie si une date a été sélectionnée

      // Les données sont cohérentes, on peut les envoyer au backend
      final Map<String, dynamic> data = {
        'textes': _titreController.text,
        'auteur': _auteurController.text,
        'image': _imagePath,
        'image2': _image2Path,
        'contenu': _contenuController.text,
      };

      context
          .read<NewsProvider>()
          .save(data: NewsModel.fromJson(data), callback: () {});
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
              editCtrller: _auteurController,
              hintText: 'Auteur',
              backColor: AppColors.kTextFormWhiteColor,
              textColor: AppColors.kWhiteColor,
            ),
            const SizedBox(height: 20),

            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ImageUploader(
                    callback: (img) {
                      _imagePath = base64Encode(img);
                      setState(() {});
                    },
                    title: "Image 1"),
                ImageUploader(
                  callback: (img) {
                    _image2Path = base64Encode(img);
                    setState(() {});
                  },
                  title: 'Image 2',
                )
              ],
            ),
            const SizedBox(height: 20),

            TextFormFieldWidget(
              maxLines: 5,
              hintText: 'Contenu',
              textColor: AppColors.kWhiteColor,
              backColor: AppColors.kTextFormWhiteColor,
              editCtrller: _contenuController,
            ),
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

class ImageUploader extends StatefulWidget {
  const ImageUploader({super.key, required this.callback, required this.title});
//  Uint8List? image;
  final Function(Uint8List) callback;
  final String title;
  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  static const int imageSize = 1;
  Uint8List? image;
  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      final double sizeInMb = result.files.first.size / (1024 * 1024);

      if (sizeInMb > imageSize) {
        ToastNotification.showToast(
            msg: "Le fichier est trop volumineux, 1mb maximum",
            msgType: MessageType.error,
            title: 'Error');
        return;
      }
      Uint8List? fileBytes = result.files.first.bytes;
      // String fileName = result.files.first.name;
      image = fileBytes;
      widget.callback(image!);
      setState(() {});
      // Upload file
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        image != null
            ? Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.memory(
                    image!,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: Icon(
                  Icons.add_photo_alternate,
                  size: 40,
                  color: Colors.grey[400],
                ),
              ),
        const SizedBox(height: 10),
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          'Select an image to upload',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            pickImage();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.kAccentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: TextWidgets.text300(
              title: "Selectionner",
              fontSize: 14,
              textColor: AppColors.kWhiteColor),
        ),
      ],
    );
  }
}
