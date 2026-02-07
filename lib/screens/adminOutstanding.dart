import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syswash/bloc/bloc/adminhome_bloc.dart';
import 'package:syswash/bloc/bloc/report_bloc.dart';
import 'package:syswash/helper/date_range_popup.dart';
import 'package:syswash/model/accounttype.dart';
import 'package:syswash/model/outstandingModel.dart';
import 'package:syswash/screens/bottomnavAdmin.dart';

class Adminoutstanding extends StatefulWidget {
  const Adminoutstanding({super.key});

  @override
  State<Adminoutstanding> createState() => _AdminoutstandingState();
}

class _AdminoutstandingState extends State<Adminoutstanding> {
  final storage = const FlutterSecureStorage(); 
  late List<OutstandingModel> outstandingModel;
  late List<AccountType> accountType;
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  Map<String, double> accountWiseTotals = {};
  num totalOutstanding = 0.0;
  String? username;
  @override
  void initState() {
    super.initState();
    _loadAndFetchData();
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
            FetchOutstandingReportEvent(
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

  String _apiDateFromUI(String uiDate) {
    final parts = uiDate.split('-'); // dd-MM-yyyy
    return "${parts[2]}-${parts[1]}-${parts[0]}";
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
        FetchOutstandingReportEvent(
          token: token,
          companyCode: companyCode,
          startDate: '',
          endDate: ''
        ),
      );
    } else {
      debugPrint('Missing userId or companyCode in storage');
    }
  }

  void _calculateTotals(List<OutstandingModel> report,List<AccountType> accounttype) {
    totalOutstanding = 0;
    accountWiseTotals.clear();

    for (final acc in accounttype) {
      if (acc.acTypeName != null && acc.trash != true) {
        accountWiseTotals[acc.acTypeName!] = 0.0;
      }
    }
    for (final item in report) {
      totalOutstanding += item.balance!;
      final accName = item.accountType;
      if (accName != null && accountWiseTotals.containsKey(accName)) {
        accountWiseTotals[accName] =
            accountWiseTotals[accName]! + item.totalAmount!.toDouble();
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
              if (state is OutstandingReportLoaded) {
                outstandingModel = state.outstandingModel;
                accountType = state.accountType;
                _calculateTotals(outstandingModel,accountType);
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
                                'Outstanding Report',
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
                            // height: 230.h,
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
                                  vertical: 20,
                                ),
                                child: Table(
                                  border: TableBorder.all(
                                    color: const Color(0xFFE7E7E7),
                                    width: 1,
                                  ),
                                  children:[ 
                                  ...accountWiseTotals.entries.map((entry) {
                                        return TableRow(
                                          children: [
                                            _tableText(entry.key),
                                            _tableValue(
                                              entry.value.toStringAsFixed(2),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                  TableRow(
                                      children: [
                                        _tableText('Total Discount'),
                                        _tableValue(
                                          totalOutstanding.toStringAsFixed(2),
                                        ),
                                      ],
                                    ), ]   
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