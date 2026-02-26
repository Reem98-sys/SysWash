import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syswash/model/salesgraph.dart';

class MonthlySalesChart extends StatelessWidget {
  final List<SalesGraph> data;

  const MonthlySalesChart({super.key, required this.data});

  // Convert int? → double safely
  List<FlSpot> _spots() {
    return List.generate(data.length, (index) {
      return FlSpot(index.toDouble(), (data[index].totalSale ?? 0).toDouble());
    });
  }

  double _maxY() {
    final max = data
        .map((e) => (e.totalSale ?? 0))
        .reduce((a, b) => a > b ? a : b);

    return max == 0 ? 1000 : max.toDouble() + 500;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: (data.length - 1).toDouble(),
          minY: 0,
          maxY: _maxY(),

          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            drawHorizontalLine: true,
            horizontalInterval: _maxY() / 4,
            verticalInterval: 1,
            getDrawingHorizontalLine:
                (value) => FlLine(
                  color: Colors.grey.shade300,
                  strokeWidth: 1,
                  dashArray: [6, 6],
                ),
            getDrawingVerticalLine:
                (value) => FlLine(
                  color: Colors.grey.shade300,
                  strokeWidth: 1,
                  dashArray: [6, 6],
                ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              left: BorderSide(color: Colors.grey.shade400, width: 1),
              bottom: BorderSide(color: Colors.grey.shade400, width: 1),
              right: BorderSide.none,
              top: BorderSide.none,
            ),
          ),

          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: _maxY() / 5,
                getTitlesWidget: (value, meta) {
                  if (value == 0) {
                    return const Text('0K', style: TextStyle(fontSize: 12));
                  }
                  return Text(
                    '${(value / 1000).toStringAsFixed(0)}K',
                    style: const TextStyle(fontSize: 12),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= data.length) {
                    return const SizedBox();
                  }
                  return Transform.rotate(
                    angle: -0.5,
                    child: Text(
                      data[index].month!.substring(0, 3).toUpperCase(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),

          lineBarsData: [
            LineChartBarData(
              isCurved: false,
              color: Colors.deepPurple,
              barWidth: 3,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, bar, index) {
                  return FlDotCirclePainter(
                    radius: 4,
                    color: Colors.white,
                    strokeWidth: 2,
                    strokeColor: Colors.deepPurple,
                  );
                },
              ),
              belowBarData: BarAreaData(show: false),
              spots: _spots(),
            ),
          ],
        ),
      ),
    );
  }
}
