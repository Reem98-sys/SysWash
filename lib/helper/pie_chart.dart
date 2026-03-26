import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpensePieChart extends StatelessWidget {
  final Map<String, double> data;

  ExpensePieChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final entries = data.entries.toList();

    return Column(
      children: [
        SizedBox(
          height: 220,
          child: PieChart(
            PieChartData(
              sections: List.generate(entries.length, (i) {
                final item = entries[i];

                return PieChartSectionData(
                  value: item.value,
                  color: _colors[i % _colors.length],
                  radius: 80,
                  title: item.value.toInt().toString(),
                  titlePositionPercentageOffset: 1.2,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                );
              }),
            ),
          ),
        ),
        const SizedBox(height: 12),

        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 8,
          children: List.generate(entries.length, (i) {
            final item = entries[i];

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  color: _colors[i % _colors.length],
                ),
                const SizedBox(width: 6),
                Text("${item.key} : ${item.value.toInt()}"),
              ],
            );
          }),
        ),
      ],
    );
  }

  final List<Color> _colors = [
    Color(0xFF4A0D3A),
    Color(0xFF6A1B5D),
    Color(0xFF9C2E8F),
    Color(0xFFC218B0),
    Color(0xFFE040FB),
  ];
}