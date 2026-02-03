import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syswash/bloc/bloc/adminhome_bloc.dart';
import 'package:syswash/bloc/bloc/report_bloc.dart';
import 'package:syswash/helper/date_range_popup.dart';
import 'package:syswash/model/itemwise.dart';
import 'package:syswash/screens/bottomnavAdmin.dart';

class Adminitemwise extends StatefulWidget {
  const Adminitemwise({super.key});

  @override
  State<Adminitemwise> createState() => _AdminitemwiseState();
}

class _AdminitemwiseState extends State<Adminitemwise> {
  final storage = const FlutterSecureStorage();
  String? username;
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  late List<ItemWise> itemWise;
  double totalQuantity = 0.0;
  double totalValue = 0.0;
  @override
  void initState() {
    super.initState();
    _loadAndFetchData();
  }

  String _apiDateFromUI(String uiDate) {
    final parts = uiDate.split('-'); // dd-MM-yyyy
    return "${parts[2]}-${parts[1]}-${parts[0]}";
  }

  void _openDatePopup() {
    showDateRangePopup(
      context: context,
      startDateController: startDateController,
      endDateController: endDateController,
      onSave: () async {
        final companyCode = await storage.read(key: 'company_Code');
        final token = await storage.read(key: 'access_Token');
  
        if (companyCode != null && token != null) {
          context.read<AdminhomeBloc>().add(
            FetchcompanyEvent(
              token: token,
              companyCode: companyCode,
            ),
          );
  
          context.read<ReportBloc>().add(
            FetchItemWiseReportEvent(
              token: token,
              companyCode: companyCode,
              startDate: _apiDateFromUI(startDateController.text),
              endDate: _apiDateFromUI(endDateController.text),
            ),
          );
        }
      },
    );
  }

  Future<void> _loadAndFetchData() async {
    final userId = await storage.read(key: 'login_id');
    final companyCode = await storage.read(key: 'company_Code');
    final token = await storage.read(key: 'access_Token');
    final storedUsername = await storage.read(key: 'user_name');
    String format(DateTime d) =>
        "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
    final dateNow = DateTime.now();
    if (mounted) {
      setState(() {
        username = storedUsername ?? 'User';
      });
    }
    print('userId : ${userId}');
    print('companyCode : ${companyCode}');
    print('token : ${token}');
    if (userId != null && companyCode != null && token != null) {
      context.read<AdminhomeBloc>().add(
        FetchcompanyEvent(token: token, companyCode: companyCode),
      );
      context.read<ReportBloc>().add(
        FetchItemWiseReportEvent(
          token: token,
          companyCode: companyCode,
          startDate: format(dateNow),
          endDate: format(dateNow),
        ),
      );
    } else {
      debugPrint('Missing userId or companyCode in storage');
    }
  }

  void _calculateTotals(
    List<ItemWise> report,
  ) {
    totalQuantity = 0;
    totalValue = 0;

    for (final item in report) {
    for (final service in item.serviceName ?? []) {
      totalQuantity += (service.quantity ?? 0);
      totalValue += (service.salesValue ?? 0);
    }
  }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new_outlined),
        ),
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
      body: Center(
        child: BlocBuilder<ReportBloc, ReportState>(
          builder: (context, state) {
            if (state is ReportLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ReportError) {
              return Center(child: Text('Failed to load data'));
            }
            if (state is ItemWiseLoaded) {
              itemWise = state.itemWise;
              _calculateTotals(itemWise);
              return Column(
                children: [
                  Container(
                    width: 362.w,
                    child: Column(
                      children: [
                        SizedBox(height: 30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Item Wise Report',
                              style: TextStyle(
                                color: const Color(0xFF150A33),
                                fontSize: 16.sp,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            IconButton(
                            icon: const Icon(Icons.filter_alt_outlined),
                            onPressed: _openDatePopup,
                          ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          width: 362.w,
                          height: 130.h,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: const Color(0xFFF0F0F0),
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              child: Table(
                                border: TableBorder.all(
                                  color: const Color(0xFFE7E7E7),
                                  width: 1,
                                ),
                                children: [
                                  TableRow(
                                    children: [
                                      _tableText('Total Quantity'),
                                      _tableValue(
                                        totalQuantity.toStringAsFixed(2),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      _tableText('Total Sales Value'),
                                      _tableValue(
                                        totalValue.toStringAsFixed(2),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                ],
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}

Widget _tableText(String data) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
    child: Text(
      data,
      style: TextStyle(
        color: const Color(0xFF150A33),
        fontSize: 14.sp,
        fontFamily: 'DM Sans',
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget _tableValue(String data) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
    child: Align(
      alignment: Alignment.centerRight,
      child: Text(
        data,
        style: TextStyle(
          color: const Color(0xFF150A33),
          fontSize: 14.sp,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}
