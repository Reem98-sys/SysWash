import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpensePieChart extends StatefulWidget {
  final Map<String, double> data;

  const ExpensePieChart({super.key, required this.data});

  @override
  State<ExpensePieChart> createState() => _ExpensePieChartState();
}

class _ExpensePieChartState extends State<ExpensePieChart> {
  int touchedIndex = -1;

  final List<Color> _colors = [
    Color(0xFF4A0D3A),
    Color(0xFF6A1B5D),
    Color(0xFF9C2E8F),
    Color(0xFFC218B0),
    Color(0xFFE040FB),
  ];

  @override
  Widget build(BuildContext context) {
    final entries = widget.data.entries.toList();

    return Column(
      children: [
        SizedBox(
          height: 220,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (event, response) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        response == null ||
                        response.touchedSection == null) {
                      touchedIndex = -1;
                    } else {
                      touchedIndex =
                          response.touchedSection!.touchedSectionIndex;
                    }
                  });
                },
              ),
              sections: List.generate(entries.length, (i) {
                final item = entries[i];
                final isTouched = i == touchedIndex;

                return PieChartSectionData(
                  value: item.value,
                  color: _colors[i % _colors.length],
                  radius: 80,
                  showTitle: false, // hide value inside pie
                  badgeWidget: isTouched
                      ? _Badge(
                          text: "${item.value.toInt()}",
                          color: _colors[i % _colors.length],
                        )
                      : null,
                  badgePositionPercentageOffset: 1.2, // position outside
                );
              }),
            ),
          ),
        ),

        const SizedBox(height: 12),

        /// LEGEND
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 8,
          children: List.generate(entries.length, (i) {
            final item = entries[i];
            final isTouched = i == touchedIndex;

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: isTouched ? 14 : 10,
                  height: isTouched ? 14 : 10,
                  color: _colors[i % _colors.length],
                ),
                const SizedBox(width: 6),
                Text(
                  "${item.key} : ${item.value.toInt()}",
                  style: TextStyle(
                    fontWeight:
                        isTouched ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}

/// Custom badge with arrow pointing to section
class _Badge extends StatelessWidget {
  final String text;
  final Color color;

  const _Badge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        // simple triangle arrow
        CustomPaint(
          size: const Size(10, 5),
          painter: _ArrowPainter(color),
        ),
      ],
    );
  }
}

class _ArrowPainter extends CustomPainter {
  final Color color;
  _ArrowPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}