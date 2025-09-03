import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../Constants/global_variables.dart';
import '../../Providers/users_provider.dart';
import 'block.model.dart';

String companyName = "Kengele App",
    address = "Goma, North Kivu, DRC",
    phone = "+243 000 000 000",
    email = "contact.kengele@applicatoryx.com";

class PrintModel {
  String title;
  String? listTitle, blockContentTitle;
  List data;
  List fields;
  BlockModel? header, client;
  List<BlockModel> blocks, footer;
  List<List<BlockModel>>? contentBlocks;
  String? startDate, endDate, assetName;
  PrintModel({
    required this.title,
    this.listTitle,
    this.blockContentTitle,
    required this.data,
    required this.fields,
    this.blocks = const [],
    this.footer = const [],
    this.contentBlocks = const [],
    this.header,
    this.client,
    this.startDate,
    this.endDate,
    this.assetName,
  });
}

pw.Widget? image;
renderImage({required String path, Size? size}) async {
  return pw.Image(
    pw.MemoryImage((await rootBundle.load(path)).buffer.asUint8List()),
    width: size?.width ?? 100,
    height: size?.height ?? 48,
  );
}

double lineSpacing = 4;

buildReport({
  required List<PrintModel> datas,
  required String orientation,
}) async {
  try {
    image = await renderImage(path: 'Assets/Images/Icons/logo-black.png');

    final pw.Document pdf = pw.Document();

    for (var i = 0; i < datas.length; i++) {
      pdf.addPage(
        pw.MultiPage(
          orientation: orientation.toLowerCase().contains('land')
              ? pw.PageOrientation.landscape
              : pw.PageOrientation.portrait,
          pageFormat: PdfPageFormat.a4.copyWith(
            marginBottom: 0.5 * PdfPageFormat.cm,
            marginLeft: 0.5 * PdfPageFormat.cm,
            marginRight: 0.5 * PdfPageFormat.cm,
          ),
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          header: (pw.Context context) {
            return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
              padding: const pw.EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
              decoration: const pw.BoxDecoration(),
              child: pw.Row(
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Row(
                        children: [
                          image!,
                          pw.SizedBox(width: 24),
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                navKey.currentContext!
                                        .read<UserProvider>()
                                        .userLogged
                                        ?.user
                                        .fullname ??
                                    BaseUrl.appName,
                                style: textStyle(
                                  fontSize: 16,
                                  weight: pw.FontWeight.bold,
                                  color: PdfColors.black,
                                ),
                              ),
                              // pw.Text(address,
                              //     style: textStyle(
                              //         fontSize: 8,
                              //         weight: pw.FontWeight.normal,
                              //         color: PdfColors.grey)),
                              // pw.Text(phone,
                              //     style: textStyle(
                              //         fontSize: 8,
                              //         weight: pw.FontWeight.normal,
                              //         color: PdfColors.grey)),
                              pw.Text(
                                navKey.currentContext!
                                        .read<UserProvider>()
                                        .userLogged
                                        ?.user
                                        .email ??
                                    BaseUrl.appContact,
                                style: textStyle(
                                  fontSize: 8,
                                  weight: pw.FontWeight.normal,
                                  color: PdfColors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          footer: (pw.Context context) {
            return pw.Container(
              margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          BaseUrl.appName,
                          style: textStyle(
                            fontSize: 10,
                            weight: pw.FontWeight.bold,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          BaseUrl.appContact,
                          style: textStyle(
                            fontSize: 8,
                            weight: pw.FontWeight.normal,
                            color: PdfColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 32),
                  pw.Text(
                    'Page ${context.pageNumber} of ${context.pagesCount}',
                  ),
                ],
              ),
            );
          },
          build: (pw.Context context) => <pw.Widget>[
            pw.Header(
              level: 0,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: <pw.Widget>[
                  pw.Text(datas[i].title, textScaleFactor: 2),
                  // pw.PdfLogo()
                ],
              ),
            ),
            if (datas[i].assetName != null && datas[i].assetName!.isNotEmpty)
              pw.Text(
                "Agent : ${datas[i].assetName ?? ''}",
                style: textStyle(
                  fontSize: 14,
                  weight: pw.FontWeight.bold,
                  color: PdfColors.black,
                ),
              ),
            pw.SizedBox(height: 8),

            // if (datas[i].startDate != null || datas[i].endDate != null)
            //   pw.Align(
            //       alignment: pw.Alignment.centerLeft,
            //       child: pw.Column(
            //           crossAxisAlignment: pw.CrossAxisAlignment.start,
            //           mainAxisAlignment: pw.MainAxisAlignment.start,
            //           children: [
            //             if (datas[i].startDate != null)
            //               pw.Text("Du : ${datas[i].startDate ?? ''}",
            //                   style: textStyle(
            //                       fontSize: 10,
            //                       weight: pw.FontWeight.normal,
            //                       color: PdfColors.black)),
            //             if (datas[i].endDate != null)
            //               pw.Text("Au : ${datas[i].endDate ?? ''}",
            //                   style: textStyle(
            //                       fontSize: 10,
            //                       weight: pw.FontWeight.normal,
            //                       color: PdfColors.black)),
            //           ])),
            if (datas[i].client != null)
              pw.Column(
                children: [
                  pw.Container(
                    width: double.maxFinite,
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.grey300,
                    ),
                    child: pw.Text(
                      datas[i].client?.title.toUpperCase() ?? '',
                      style: textStyle(
                        fontSize: 10,
                        weight: pw.FontWeight.bold,
                        color: PdfColors.black,
                      ),
                    ),
                  ),
                  ...List.generate(datas[i].client!.fields.length, (index) {
                    return pw.Column(
                      children: [
                        pw.Flex(
                          direction: pw.Axis.horizontal,
                          children: [
                            pw.Text(
                              '${datas[i].client!.fields[index].toUpperCase().replaceAll('_', ' ')}:',
                              style: textStyle(
                                fontSize: 10,
                                weight: pw.FontWeight.normal,
                                color: PdfColors.black,
                              ),
                            ),
                            // pw.SizedBox(width: 16, height: 16),
                            pw.Flexible(child: pw.Container()),
                            pw.Text(
                              datas[i]
                                  .client!
                                  .data[datas[i].client!.fields[index]],
                              style: textStyle(
                                fontSize: 10,
                                weight: pw.FontWeight.bold,
                                color: PdfColors.black,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: lineSpacing),
                      ],
                    );
                  }),
                  pw.SizedBox(height: 16),
                ],
              ),
            if (datas[i].header != null)
              pw.Column(
                children: [
                  pw.Container(
                    width: double.maxFinite,
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.grey300,
                    ),
                    child: pw.Text(
                      datas[i].header?.title.toUpperCase() ?? '',
                      style: textStyle(
                        fontSize: 10,
                        weight: pw.FontWeight.bold,
                        color: PdfColors.black,
                      ),
                    ),
                  ),
                  ...List.generate(datas[i].header!.fields.length, (index) {
                    return pw.Column(
                      children: [
                        pw.Flex(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          direction: pw.Axis.horizontal,
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                '${datas[i].header!.fields[index].toUpperCase().replaceAll('_', ' ')}:',
                                style: textStyle(
                                  fontSize: 10,
                                  weight: pw.FontWeight.normal,
                                  color: PdfColors.black,
                                ),
                              ),
                            ),
                            pw.SizedBox(width: 16, height: 16),
                            pw.Expanded(
                              flex: 3,
                              child: pw.Text(
                                datas[i]
                                    .header!
                                    .data[datas[i].header!.fields[index]],
                                textAlign: pw.TextAlign.right,
                                style: textStyle(
                                  fontSize: 10,
                                  weight: pw.FontWeight.bold,
                                  color: PdfColors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: lineSpacing),
                      ],
                    );
                  }),
                  pw.SizedBox(height: 16),
                ],
              ),
            if (datas[i].blockContentTitle != null &&
                datas[i].blockContentTitle != '')
              pw.Container(
                width: double.maxFinite,
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: const pw.BoxDecoration(color: PdfColors.grey300),
                child: pw.Text(
                  datas[i].blockContentTitle ?? '',
                  style: textStyle(
                    fontSize: 12,
                    weight: pw.FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
              ),
            pw.SizedBox(height: 16),
            if (datas[i].listTitle != null && datas[i].listTitle != '')
              pw.Container(
                width: double.maxFinite,
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: const pw.BoxDecoration(color: PdfColors.grey300),
                child: pw.Text(
                  datas[i].listTitle?.toUpperCase() ?? '',
                  style: textStyle(
                    fontSize: 10,
                    weight: pw.FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
              ),
            if (datas[i].listTitle != null && datas[i].listTitle != '')
              pw.SizedBox(height: 8),
            if (datas[i].fields.isNotEmpty && datas[i].data.isNotEmpty)
              pw.Table.fromTextArray(
                cellAlignment: pw.Alignment.centerLeft,
                headerAlignment: pw.Alignment.centerLeft,
                rowDecoration: const pw.BoxDecoration(color: PdfColors.white),
                border: pw.TableBorder.all(color: PdfColors.grey200),
                oddRowDecoration: pw.BoxDecoration(
                  color: PdfColors.blue100.shade(0.4),
                ),
                context: context,
                cellStyle: textStyle(
                  fontSize: 7,
                  weight: pw.FontWeight.normal,
                  color: PdfColors.black,
                ),
                oddCellStyle: textStyle(
                  fontSize: 7,
                  weight: pw.FontWeight.normal,
                  color: PdfColors.black,
                ),
                headerStyle: textStyle(
                  fontSize: 6,
                  weight: pw.FontWeight.bold,
                  color: PdfColors.black,
                ),
                // headers
                data: <List<String>>[
                  List.generate(
                    datas[i].fields.length,
                    (index) => datas[i]
                        .fields[index]
                        .toString()
                        .toUpperCase()
                        .replaceAll('_', ' '),
                  ),
                  ...datas[i].data.map((e) {
                    // print(e);
                    return List.generate(
                      datas[i].fields.length,
                      (indexCol) =>
                          e[datas[i].fields[indexCol]]?.toString() ?? '',
                    );
                  }),
                ],
              ),
            if (datas[i].listTitle != null && datas[i].listTitle != '')
              pw.SizedBox(height: 8),
            if (datas[i].fields.isNotEmpty && datas[i].data.isNotEmpty) ...[
              ...List.generate(datas[i].blocks.length, (index) {
                BlockModel currentBlock = datas[i].blocks[index];
                return pw.Column(
                  children: [
                    pw.Container(
                      width: double.maxFinite,
                      padding: const pw.EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      child: pw.Text(
                        currentBlock.title.toUpperCase(),
                        style: textStyle(
                          fontSize: 10,
                          weight: pw.FontWeight.bold,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Table.fromTextArray(
                      cellAlignment: pw.Alignment.centerLeft,
                      headerAlignment: pw.Alignment.centerLeft,
                      rowDecoration: const pw.BoxDecoration(
                        color: PdfColors.white,
                      ),
                      border: pw.TableBorder.all(color: PdfColors.grey200),
                      oddRowDecoration: pw.BoxDecoration(
                        color: PdfColors.blue100.shade(0.4),
                      ),
                      context: context,
                      cellStyle: textStyle(
                        fontSize: 7,
                        weight: pw.FontWeight.normal,
                        color: PdfColors.black,
                      ),
                      oddCellStyle: textStyle(
                        fontSize: 7,
                        weight: pw.FontWeight.normal,
                        color: PdfColors.black,
                      ),
                      headerStyle: textStyle(
                        fontSize: 6,
                        weight: pw.FontWeight.bold,
                        color: PdfColors.black,
                      ),
                      // headers
                      data: <List<String>>[
                        List.generate(
                          currentBlock.fields.length,
                          (fieldIndex) => currentBlock.fields[fieldIndex]
                              .toString()
                              .toUpperCase()
                              .replaceAll('_', ' '),
                        ),
                        ...[
                          List.generate(
                            currentBlock.fields.length,
                            (indexCol) =>
                                currentBlock.data[currentBlock.fields[indexCol]]
                                    ?.toString() ??
                                '',
                          ),
                        ],
                      ],
                    ),
                    pw.SizedBox(height: 8),
                  ],
                );
              }),
            ],

            if (datas[i].fields.isNotEmpty && datas[i].data.isNotEmpty)
              pw.SizedBox(height: 16),
            ...List.generate(datas[i].footer.length, (index) {
              BlockModel currentBlock = datas[i].footer[index];
              return pw.Column(
                children: [
                  pw.Container(
                    width: double.maxFinite,
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.grey300,
                    ),
                    child: pw.Text(
                      currentBlock.title.toUpperCase(),
                      style: textStyle(
                        fontSize: 10,
                        weight: pw.FontWeight.bold,
                        color: PdfColors.black,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Column(
                    // direction: currentBlock.type == 'row'
                    //     ? pw.Axis.horizontal
                    //     : pw.Axis.vertical,
                    children: [
                      ...List.generate(currentBlock.fields.length, (index) {
                        return pw.Column(
                          children: [
                            pw.Row(
                              // direction: pw.Axis.horizontal,
                              mainAxisSize: pw.MainAxisSize.min,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Expanded(
                                  child: pw.Text(
                                    currentBlock.fields[index]
                                        .toUpperCase()
                                        .replaceAll('_', ' '),
                                    style: textStyle(
                                      fontSize: 10,
                                      weight: pw.FontWeight.normal,
                                      color: PdfColors.black,
                                    ),
                                  ),
                                ),
                                pw.SizedBox(width: 16, height: 16),
                                pw.Expanded(
                                  flex: 3,
                                  child: pw.Text(
                                    currentBlock
                                        .data[currentBlock.fields[index]],
                                    textAlign: pw.TextAlign.left,
                                    style: textStyle(
                                      fontSize: 10,
                                      weight: pw.FontWeight.bold,
                                      color: PdfColors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: lineSpacing),
                          ],
                        );
                      }),
                    ],
                  ),
                ],
              );
            }),
          ],
        ),
      );
    }

    Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => await pdf.save(),
    );
  } catch (e) {
    print(e.toString());
  }
}

textStyle({
  required double fontSize,
  required pw.FontWeight weight,
  required PdfColor color,
}) {
  return pw.TextStyle(fontSize: fontSize, fontWeight: weight, color: color);
}

textHorizontal({
  required String title,
  required String value,
  double? fontSize = 12,
  PdfColor? textColor = PdfColors.black,
}) {
  return pw.Row(
    mainAxisSize: pw.MainAxisSize.min,
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        title,
        style: textStyle(
          fontSize: fontSize!,
          weight: pw.FontWeight.bold,
          color: textColor!,
        ),
      ),
      pw.SizedBox(width: 16),
      pw.Text(
        value,
        style: textStyle(
          fontSize: fontSize,
          weight: pw.FontWeight.bold,
          color: textColor,
        ),
      ),
    ],
  );
}

buildTableReport({
  required String orientation,
  required List<BlockModel> mainData,
  required List<ListBlockModel> lists,
  required String title,
}) async {
  image = await renderImage(path: 'Assets/Images/logo.png');
  final pw.Document pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      orientation: orientation.toLowerCase().contains('land')
          ? pw.PageOrientation.landscape
          : pw.PageOrientation.portrait,
      pageFormat: PdfPageFormat.a4.copyWith(
        marginBottom: 0.5 * PdfPageFormat.cm,
        marginLeft: 0.5 * PdfPageFormat.cm,
        marginRight: 0.5 * PdfPageFormat.cm,
      ),
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      header: (pw.Context context) {
        return pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
          padding: const pw.EdgeInsets.only(bottom: 1.0 * PdfPageFormat.mm),
          decoration: const pw.BoxDecoration(),
          child: pw.Row(
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Row(children: [image!]),
                  pw.Text(
                    companyName,
                    style: textStyle(
                      fontSize: 16,
                      weight: pw.FontWeight.bold,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.Text(
                    address,
                    style: textStyle(
                      fontSize: 8,
                      weight: pw.FontWeight.normal,
                      color: PdfColors.grey,
                    ),
                  ),
                  pw.Text(
                    phone,
                    style: textStyle(
                      fontSize: 8,
                      weight: pw.FontWeight.normal,
                      color: PdfColors.grey,
                    ),
                  ),
                  pw.Text(
                    email,
                    style: textStyle(
                      fontSize: 8,
                      weight: pw.FontWeight.normal,
                      color: PdfColors.grey,
                    ),
                  ),
                ],
              ),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text(
                      BaseUrl.appName,
                      style: textStyle(
                        fontSize: 16,
                        weight: pw.FontWeight.bold,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.Text(
                      'RCCM:7388327',
                      style: textStyle(
                        fontSize: 12,
                        weight: pw.FontWeight.normal,
                        color: PdfColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      footer: (pw.Context context) {
        return pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
          child: pw.Text('Page ${context.pageNumber} of ${context.pagesCount}'),
        );
      },
      build: (pw.Context context) => <pw.Widget>[
        pw.Header(
          level: 0,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: <pw.Widget>[pw.Text(title, textScaleFactor: 2)],
          ),
        ),
        ...List.generate(
          mainData.length,
          (index) => pw.Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              pw.Container(
                width: double.maxFinite,
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: const pw.BoxDecoration(color: PdfColors.grey300),
                child: pw.Text(
                  mainData[index].title.toUpperCase(),
                  style: textStyle(
                    fontSize: 10,
                    weight: pw.FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
              ),
              ...List.generate(mainData[index].fields.length, (colIndex) {
                return pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      '${mainData[index].fields[colIndex].toUpperCase().replaceAll('_', ' ')} :',
                      style: textStyle(
                        fontSize: 10,
                        weight: pw.FontWeight.normal,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.Text(
                      mainData[index].data[mainData[index].fields[colIndex]],
                      style: textStyle(
                        fontSize: 10,
                        weight: pw.FontWeight.bold,
                        color: PdfColors.black,
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
        pw.SizedBox(height: 16),
        ...List.generate(
          lists.length,
          (index) => pw.Column(
            children: [
              pw.Row(),
              pw.Container(
                width: double.maxFinite,
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: const pw.BoxDecoration(color: PdfColors.grey300),
                child: pw.Text(
                  lists[index].title.toUpperCase(),
                  style: textStyle(
                    fontSize: 10,
                    weight: pw.FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
              ),
              pw.Table.fromTextArray(
                cellAlignment: pw.Alignment.centerLeft,
                headerAlignment: pw.Alignment.centerLeft,
                rowDecoration: const pw.BoxDecoration(color: PdfColors.white),
                border: pw.TableBorder.all(color: PdfColors.grey200),
                oddRowDecoration: pw.BoxDecoration(
                  color: PdfColors.blue100.shade(0.4),
                ),
                context: context,
                cellStyle: textStyle(
                  fontSize: 10,
                  weight: pw.FontWeight.normal,
                  color: PdfColors.black,
                ),
                oddCellStyle: textStyle(
                  fontSize: 10,
                  weight: pw.FontWeight.normal,
                  color: PdfColors.black,
                ),
                headerStyle: textStyle(
                  fontSize: 10,
                  weight: pw.FontWeight.bold,
                  color: PdfColors.black,
                ),
                // headers
                data: <List<String>>[
                  List.generate(
                    lists[index].fields.length,
                    (fieldIndex) => lists[index]
                        .fields[fieldIndex]
                        .toString()
                        .toUpperCase()
                        .replaceAll('_', ' '),
                  ),
                  ...lists[index].data.map((e) {
                    // print(e);
                    return List.generate(lists[index].fields.length, (
                      indexCol,
                    ) {
                      return e[lists[index].fields[indexCol].toString()]
                              ?.toString() ??
                          '';
                    });
                  }),
                ],
              ),
              pw.SizedBox(height: 16),
            ],
          ),
        ),
        pw.SizedBox(height: 8),
        pw.SizedBox(height: 8),
      ],
    ),
  );
  Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => await pdf.save(),
  );
}
