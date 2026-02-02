import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syswash/bloc/bloc/adminhome_bloc.dart';
import 'package:syswash/bloc/bloc/report_bloc.dart';

class Admincustomerreport extends StatefulWidget {
  const Admincustomerreport({super.key});

  @override
  State<Admincustomerreport> createState() => _AdmincustomerreportState();
}

class _AdmincustomerreportState extends State<Admincustomerreport> {
  String? username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new_outlined)),
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, ${username}!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Welcome',
              style: TextStyle(
                color: const Color(0xFFBFBFBF),
                fontSize: 14.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          BlocBuilder<AdminhomeBloc, AdminhomeState>(
            builder: (context, state) {
              if (state is AdmincompanyLoaded &&
                  state.companyDetails.imageLightMode != null &&
                  state.companyDetails.imageLightMode!.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Image.network(
                    state.companyDetails.imageLightMode!,
                    width: 115.w,
                    height: 35.h,
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: BlocBuilder<ReportBloc, ReportState>(
            builder: (context, state) {
              if (state is ReportLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ReportError) {
                return Center(child: Text('Failed to load data'));
              }
              // if (state is ReportLoaded) {
                // orderReport = state.orderReport;
                // accountType = state.accountType;
                // _calculateTotals(orderReport, accountType);
                // return Column(
                //   children: [
                //     Container(
                //       width: 362.w,
                //       child: Column(
                //         children: [
                //           Row(
                //             children: [
                //               Text(
                //                 'Order Report',
                //                 style: TextStyle(
                //                   color: const Color(0xFF150A33),
                //                   fontSize: 16.sp,
                //                   fontFamily: 'DM Sans',
                //                   fontWeight: FontWeight.w700,
                //                 ),
                //               ),
                //             ],
                //           ),
                //           SizedBox(height: 10.h),
                //           Container(
                //             width: 362.w,
                //             height: 230.h,
                //             decoration: ShapeDecoration(
                //               color: Colors.white,
                //               shape: RoundedRectangleBorder(
                //                 side: BorderSide(
                //                   width: 1,
                //                   color: const Color(0xFFF0F0F0),
                //                 ),
                //                 borderRadius: BorderRadius.circular(15),
                //               ),
                //             ),
                //             child: Center(
                //               child: Padding(
                //                 padding: const EdgeInsets.symmetric(
                //                   horizontal: 25,
                //                 ),
                //                 child: Table(
                //                   border: TableBorder.all(
                //                     color: const Color(0xFFE7E7E7),
                //                     width: 1,
                //                   ),
                //                   children: [
                //                     TableRow(
                //                       children: [
                //                         _tableText('Total Amount'),
                //                         _tableValue(
                //                           totalAmount.toStringAsFixed(2),
                //                         ),
                //                       ],
                //                     ),
                //                     TableRow(
                //                       children: [
                //                         _tableText('Total Discount'),
                //                         _tableValue(
                //                           totalDiscount.toStringAsFixed(2),
                //                         ),
                //                       ],
                //                     ),
                //                     TableRow(
                //                       children: [
                //                         _tableText('Total Paid'),
                //                         _tableValue(
                //                           totalPaid.toStringAsFixed(2),
                //                         ),
                //                       ],
                //                     ),
                //                     TableRow(
                //                       children: [
                //                         _tableText('Total Balance'),
                //                         _tableValue(
                //                           totalBalance.toStringAsFixed(2),
                //                         ),
                //                       ],
                //                     ),
                //                     TableRow(
                //                       children: [
                //                         _tableText('Total Commission'),
                //                         _tableValue(
                //                           totalCommission.toStringAsFixed(2),
                //                         ),
                //                       ],
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // );
              // } /
              else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}