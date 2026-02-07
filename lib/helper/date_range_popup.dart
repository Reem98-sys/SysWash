import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showDateRangePopup({
  required BuildContext context,
  required TextEditingController startDateController,
  required TextEditingController endDateController,
  required VoidCallback onSave,
}) {
  return showDialog(
    context: context,
    builder: (dialogContext) {
      final now = DateTime.now();
      final today =
          "${now.day.toString().padLeft(2, '0')}-"
          "${now.month.toString().padLeft(2, '0')}-"
          "${now.year}";

      if (startDateController.text.isEmpty) {
        startDateController.text = today;
      }
      if (endDateController.text.isEmpty) {
        endDateController.text = today;
      }
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select Date Range',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(dialogContext),
                    child: Icon(Icons.cancel, size: 28.sp),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// Date fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _dateField(
                    label: 'Start Date',
                    controller: startDateController,
                    context: context,
                  ),
                  _dateField(
                    label: 'End Date',
                    controller: endDateController,
                    context: context,
                  ),
                ],
              ),

              SizedBox(height: 18.h),

              /// Save button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    onSave();
                    Navigator.pop(dialogContext);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF68188B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'SAVE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

/// ---------- Reusable Date Field ----------
Widget _dateField({
  required String label,
  required TextEditingController controller,
  required BuildContext context,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          color: const Color(0xFF150B3D),
          fontSize: 14.sp,
          fontFamily: 'DM Sans',
        ),
      ),
      SizedBox(height: 10.h),
      Container(
        width: 160.w,
        height: 50.h,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                readOnly: true,
                onTap: () => _selectDate(context, controller),
                decoration: const InputDecoration(
                  hintText: 'Date',
                  border: InputBorder.none,
                ),
              ),
            ),
            const Icon(Icons.calendar_month, color: Colors.grey),
          ],
        ),
      ),
    ],
  );
}

/// ---------- Date Picker ----------
Future<void> _selectDate(
  BuildContext context,
  TextEditingController controller,
) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2010),
    lastDate: DateTime(2060),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF6A1B9A),
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
        ),
        child: child!,
      );
    },
  );

  if (picked != null) {
    controller.text =
        "${picked.day.toString().padLeft(2, '0')}-"
        "${picked.month.toString().padLeft(2, '0')}-"
        "${picked.year}";
  }
}
