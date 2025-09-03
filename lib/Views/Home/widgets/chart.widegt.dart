// Model to hold the data for each month.
import 'package:flutter/material.dart';

class MonthlyData {
  final String month;
  final double farmer;
  final double production;
  final double exportation;

  MonthlyData({
    required this.month,
    required this.farmer,
    required this.production,
    required this.exportation,
  });
}

// This widget holds the logic and data for the bar chart.
class MonthlyBarChart extends StatelessWidget {
  const MonthlyBarChart({super.key});

  // Data for the three categories (Farmer, Production, Exportation) for 6 months, now in a list of a custom model.
  static final List<MonthlyData> monthlyData = [
    MonthlyData(month: 'Jan', farmer: 12, production: 10, exportation: 8),
    MonthlyData(month: 'Feb', farmer: 15, production: 13, exportation: 11),
    MonthlyData(month: 'Mar', farmer: 14, production: 11, exportation: 9),
    MonthlyData(month: 'Apr', farmer: 18, production: 16, exportation: 14),
    MonthlyData(month: 'May', farmer: 20, production: 18, exportation: 15),
    MonthlyData(month: 'Jun', farmer: 16, production: 14, exportation: 12),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // The title and legend for the chart.
            // const Text(
            //   'Monthly Comparison',
            //   style: TextStyle(
            //     fontSize: 22,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.black87,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            SizedBox(height: 16),
            // _buildLegend(),
            SizedBox(height: 16),
            // The main chart widget.
            // SizedBox(
            //   height: 300,
            //   child: BarChart(
            //     _buildBarChartData(),
            //     swapAnimationDuration: const Duration(milliseconds: 150),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // // Creates the `BarChartData` object with all the configurations.
  // BarChartData _buildBarChartData() {
  //   return BarChartData(
  //     alignment: BarChartAlignment.spaceAround,
  //     barGroups: _buildBarGroups(),
  //     borderData: FlBorderData(
  //       show: true,
  //       border: const Border(
  //         bottom: BorderSide(color: Colors.grey, width: 1),
  //         left: BorderSide(color: Colors.grey, width: 1),
  //       ),
  //     ),
  //     titlesData: FlTitlesData(
  //       show: true,
  //       bottomTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           getTitlesWidget: _getBottomTitles,
  //           reservedSize: 32,
  //         ),
  //       ),
  //       leftTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           reservedSize: 40,
  //           getTitlesWidget: (value, meta) {
  //             return Text(
  //               '${value.toInt()}',
  //               style: const TextStyle(color: Colors.black, fontSize: 12),
  //             );
  //           },
  //           interval: 5, // Shows a title every 5 units on the Y-axis.
  //         ),
  //       ),
  //       topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  //       rightTitles: const AxisTitles(
  //         sideTitles: SideTitles(showTitles: false),
  //       ),
  //     ),
  //     gridData: FlGridData(
  //       show: true,
  //       drawHorizontalLine: true,
  //       drawVerticalLine: false,
  //       horizontalInterval: 5,
  //       getDrawingHorizontalLine: (value) =>
  //           FlLine(color: Colors.grey.withOpacity(0.3), strokeWidth: 1),
  //     ),
  //     // Optional: Add a tooltip to show values on hover/tap.
  //     barTouchData: BarTouchData(
  //       touchTooltipData: BarTouchTooltipData(
  //         // tooltipBgColor: Colors.blueGrey,
  //         getTooltipItem: (group, groupIndex, rod, rodIndex) {
  //           String label;
  //           double value;
  //           switch (rodIndex) {
  //             case 0:
  //               label = 'Agriculteurs';
  //               value = monthlyData[groupIndex].farmer;
  //               break;
  //             case 1:
  //               label = 'Production';
  //               value = monthlyData[groupIndex].production;
  //               break;
  //             case 2:
  //               label = 'Exportation';
  //               value = monthlyData[groupIndex].exportation;
  //               break;
  //             default:
  //               label = '';
  //               value = 0.0;
  //           }
  //           return BarTooltipItem(
  //             '$label: ${value.toInt()}',
  //             const TextStyle(color: Colors.white),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  // // Creates a list of `BarChartGroupData` for each month.
  // List<BarChartGroupData> _buildBarGroups() {
  //   List<BarChartGroupData> barGroups = [];
  //   const double barWidth = 12;
  //   const double spaceBetweenBars = 2;

  //   for (int i = 0; i < monthlyData.length; i++) {
  //     final data = monthlyData[i];
  //     barGroups.add(
  //       BarChartGroupData(
  //         x: i,
  //         barRods: [
  //           BarChartRodData(
  //             toY: data.farmer,
  //             color: Colors.blue,
  //             width: barWidth,
  //             borderRadius: BorderRadius.circular(2),
  //           ),
  //           BarChartRodData(
  //             toY: data.production,
  //             color: Colors.green,
  //             width: barWidth,
  //             borderRadius: BorderRadius.circular(2),
  //           ),
  //           BarChartRodData(
  //             toY: data.exportation,
  //             color: Colors.orange,
  //             width: barWidth,
  //             borderRadius: BorderRadius.circular(2),
  //           ),
  //         ],
  //         barsSpace: spaceBetweenBars,
  //       ),
  //     );
  //   }
  //   return barGroups;
  // }

  // // Provides the widget for the bottom axis titles (the month names).
  // Widget _getBottomTitles(double value, TitleMeta meta) {
  //   const style = TextStyle(
  //     color: Colors.black,
  //     fontWeight: FontWeight.bold,
  //     fontSize: 12,
  //   );
  //   final int index = value.toInt();
  //   Widget text = Text(monthlyData[index].month, style: style);
  //   return SideTitleWidget(
  //     axisSide: meta.axisSide,
  //     space: 8.0,
  //     // meta: meta,
  //     child: text,
  //   );
  // }

  // // Helper method to build the color-coded legend for the chart.
  // Widget _buildLegend() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       _buildLegendItem(Colors.blue, 'Agriculteurs'),
  //       const SizedBox(width: 16),
  //       _buildLegendItem(Colors.green, 'Production'),
  //       const SizedBox(width: 16),
  //       _buildLegendItem(Colors.orange, 'Exportation'),
  //     ],
  //   );
  // }

  // // Helper method to create a single legend item.
  // Widget _buildLegendItem(Color color, String text) {
  //   return Row(
  //     children: [
  //       Container(
  //         width: 16,
  //         height: 16,
  //         decoration: BoxDecoration(
  //           color: color,
  //           borderRadius: BorderRadius.circular(2),
  //         ),
  //       ),
  //       const SizedBox(width: 4),
  //       Text(
  //         text,
  //         style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  //       ),
  //     ],
  //   );
  // }
}
