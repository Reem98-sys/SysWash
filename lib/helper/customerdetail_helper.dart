import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<TableRow> buildDetailsTableRows(List<Map<String, String?>> items) {
  const int columns = 3;
  final rows = <TableRow>[];

  for (int i = 0; i < items.length; i += columns) {
    rows.add(
      TableRow(
        children: List.generate(columns, (index) {
          final itemIndex = i + index;
          if (itemIndex >= items.length) {
            return const SizedBox(); // empty cell
          }
          final item = items[itemIndex];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: tableCell(item['label']!, item['value'] ?? '-'),
          );
        }),
      ),
    );
  }
  return rows;
}
Widget tableCell(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          color: const Color(0xFFA9A5B8),
          fontSize: 14.sp,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 2),
      Text(
        value.isEmpty ? '-' : value,
        style: TextStyle(
          color: Colors.black,
          fontSize: 12.sp,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w500,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}