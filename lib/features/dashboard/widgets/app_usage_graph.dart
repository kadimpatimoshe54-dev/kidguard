import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AppUsageGraph extends StatelessWidget {
  const AppUsageGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Today's App Usage (Hours)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 6,
                  barTouchData: BarTouchData(enabled: true),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          String text = '';
                          switch (value.toInt()) {
                            case 0:
                              text = 'YouTube';
                              break;
                            case 1:
                              text = 'FreeFire';
                              break;
                            case 2:
                              text = 'WhatsApp';
                              break;
                            case 3:
                              text = 'Chrome';
                              break;
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(text, style: const TextStyle(fontSize: 12)),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 28),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 3.5, color: Colors.red, width: 16)]),
                    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 4.2, color: Colors.orange, width: 16)]),
                    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 1.5, color: Colors.green, width: 16)]),
                    BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 2.0, color: Colors.blue, width: 16)]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
