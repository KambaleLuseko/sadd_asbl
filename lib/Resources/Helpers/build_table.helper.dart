import 'package:flutter/material.dart';

import '../Components/button.dart';
import '../Components/empty_model.dart';
import '../Components/texts.dart';
import '../Constants/global_variables.dart';

class BuildTable {
  static generateTable(
      {required List<String> columns,
      required List<Map> rows,
      Color? textColor = Colors.white,
      Function(Map)? editCallback,
      Function(Map)? deleteCallback,
      Function(Map)? itemClickCallback}) {
    return rows.isEmpty
        ? EmptyModel(color: AppColors.kWhiteColor)
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DataTable(
                        // dataRowHeight: 48,
                        showCheckboxColumn: false,
                        dividerThickness: 1,
                        columns: [
                          ...columns.map((e) => DataColumn(
                              label: TextWidgets.textBold(
                                  title: e.toUpperCase().replaceAll('_', ''),
                                  fontSize: 16,
                                  textColor: textColor!))),
                          if (editCallback != null || deleteCallback != null)
                            DataColumn(
                                label: TextWidgets.textBold(
                                    title: "ACTIONS",
                                    fontSize: 16,
                                    textColor: textColor!))
                        ],
                        rows: rows
                            .map((row) => DataRow(
                                    onSelectChanged: (value) {
                                      if (itemClickCallback != null) {
                                        // print(row);
                                        itemClickCallback(row);
                                      }
                                    },
                                    cells: [
                                      ...columns.map((col) {
                                        return DataCell(TextWidgets.text300(
                                            title: row[col]?.toString() ?? '',
                                            fontSize: 14,
                                            textColor: textColor!));
                                      }),
                                      if (editCallback != null ||
                                          deleteCallback != null)
                                        DataCell(Row(
                                          children: [
                                            if (editCallback != null)
                                              IconButtonWidget(
                                                  backColor:
                                                      AppColors.kGreenColor,
                                                  textColor:
                                                      AppColors.kWhiteColor,
                                                  callback: () {
                                                    // print(row);
                                                    editCallback(row);
                                                  },
                                                  icon: Icons
                                                      .border_color_rounded),
                                            if (deleteCallback != null)
                                              IconButtonWidget(
                                                  backColor:
                                                      AppColors.kRedColor,
                                                  textColor:
                                                      AppColors.kWhiteColor,
                                                  callback: () {
                                                    deleteCallback(row);
                                                  },
                                                  icon: Icons.delete)
                                          ],
                                        )),
                                    ]))
                            .toList()),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidgets.textNormal(
                      title: "${rows.length} element(s)",
                      fontSize: 12,
                      textColor: textColor!)
                ],
              )
            ],
          );
  }
}
