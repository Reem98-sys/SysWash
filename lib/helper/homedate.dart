import 'package:flutter/material.dart';

class DateRangeFilter extends StatefulWidget {
  final Function(DateTime?, DateTime?) onApply;

  const DateRangeFilter({super.key, required this.onApply});

  @override
  State<DateRangeFilter> createState() => _DateRangeFilterState();
}

class _DateRangeFilterState extends State<DateRangeFilter> {
  DateTime? fromDate;
  DateTime? toDate;

  Future<void> pickFromDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fromDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() => fromDate = picked);
    }
  }

  Future<void> pickToDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: toDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() => toDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          /// FROM DATE
          Expanded(
            child: GestureDetector(
              onTap: pickFromDate,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  fromDate == null
                      ? "From Date"
                      : "${fromDate!.day}-${fromDate!.month}-${fromDate!.year}",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          /// TO DATE
          Expanded(
            child: GestureDetector(
              onTap: pickToDate,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  toDate == null
                      ? "To Date"
                      : "${toDate!.day}-${toDate!.month}-${toDate!.year}",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          /// APPLY BUTTON
          ElevatedButton(
            onPressed: () {
              widget.onApply(fromDate, toDate);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Icon(Icons.search),
          )
        ],
      ),
    );
  }
}