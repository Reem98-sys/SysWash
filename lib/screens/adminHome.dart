import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syswash/bloc/bloc/adminbranch_bloc.dart';
import 'package:syswash/bloc/bloc/adminclosereport_bloc.dart';
import 'package:syswash/bloc/bloc/admingraph_bloc.dart';
import 'package:syswash/bloc/bloc/adminhome_bloc.dart';
import 'package:syswash/helper/graph.dart';
import 'package:syswash/model/adminBranch.dart' as branch_model;
import 'package:syswash/model/closingReport.dart';
import 'package:syswash/model/companydetailsModel.dart';
import 'package:syswash/model/totalCountModel.dart';

class Adminhome extends StatefulWidget {
  const Adminhome({super.key});

  @override
  State<Adminhome> createState() => _AdminhomeState();
}

class _AdminhomeState extends State<Adminhome> {
  final storage = const FlutterSecureStorage();
  late TotalCount totalCount;
  late ClosingReport closingReport;
  late CompanyDetails companyDetails;
  branch_model.AdminBranch? adminBranch;
  List<branch_model.Data> branchList = [];
  String? selectedBranch = null;
  bool branchInitialized = false;

  String dropdownValue = 'Daily';
  var range = ['Daily', 'Yesterday', 'Weekly', 'Monthly'];
  String? username;
  @override
  void initState() {
    super.initState();
    _loadAndFetchData();
  }

  Map<String, String> getDateRange(String type) {
    final now = DateTime.now();

    DateTime startDate;
    DateTime endDate = now;

    switch (type) {
      case 'Daily':
        startDate = now;
        break;

      case 'Yesterday':
        startDate = now.subtract(const Duration(days: 1));
        endDate = startDate;
        break;

      case 'Weekly':
        startDate = now.subtract(const Duration(days: 7));
        break;

      case 'Monthly':
        startDate = now.subtract(const Duration(days: 31));
        break;

      default:
        startDate = now;
    }

    String format(DateTime d) =>
        "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";

    return {"startDate": format(startDate), "endDate": format(endDate)};
  }

  Future<void> _loadAndFetchData() async {
    final userId = await storage.read(key: 'login_id');
    final companyCode = await storage.read(key: 'company_Code');
    final token = await storage.read(key: 'access_Token');
    final storedUsername = await storage.read(key: 'user_name');
    if (mounted) {
      setState(() {
        username = storedUsername ?? 'User';
      });
    }
    print('userId : ${userId}');
    print('companyCode : ${companyCode}');
    print('token : ${token}');
    if (userId != null && companyCode != null && token != null) {
      final dates = getDateRange(dropdownValue); // Daily by default

      context.read<AdminhomeBloc>().add(
        FetchtotalsaleEvent(token: token, companyCode: companyCode, branch: ''),
      );
      context.read<AdminbranchBloc>().add(
        FetchBranchEvent(token: token, companyCode: companyCode),
      );
      context.read<AdminclosereportBloc>().add(
        FetchClosingReportEvent(
          token: token,
          companyCode: companyCode,
          startDate: dates['startDate']!,
          endDate: dates['endDate']!,
        ),
      );
      context.read<AdmingraphBloc>().add(
        FetchSalesGraphEvent(token: token, companyCode: companyCode,branch: null),
      );
    } else {
      debugPrint('Missing userId or companyCode in storage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              if (state is AdmintotalsaleLoaded &&
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
      body: BlocListener<AdminbranchBloc, AdminbranchState>(
        listener: (context, state) {
          if (state is AdminBranchLoaded && !branchInitialized) {
            setState(() {
              branchList = [
                branch_model.Data(
                  branchCode: null,
                  branchName: 'All Branch',
                ),
                ...(state.adminBranch.data ?? []),
              ];

              selectedBranch = null; // default → all branch
              branchInitialized = true;
            });
          }
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 16.h),
                BlocBuilder<AdminbranchBloc, AdminbranchState>(
                  builder: (context, state) {
                    if (state is AdminBranchLoaded) {
                      adminBranch = state.adminBranch;

                      if (branchList.isEmpty) return const SizedBox();

                      return Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 0, 35.w, 16.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 150.w,
                                  // height: 30.h,
                                  child: DropdownButtonFormField<String>(
                                    value: selectedBranch,
                                    isExpanded: true,
                                    isDense: true,
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 20,
                                      color: const Color(0xFF822BA8),
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Select Branch',
                                      isDense: true,
                                      contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 8.w,
                                                  vertical: 2.h,
                                                ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.r),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.r),
                                        borderSide: const BorderSide(
                                          color: Color(0xFF822BA8), // purple border
                                          width: 1.4,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.r),
                                        borderSide: const BorderSide(
                                          color: Color(0xFF822BA8),
                                          width: 1.6,
                                        ),
                                      ),
                                    ),
                                    items:
                                        branchList.map<DropdownMenuItem<String>>((
                                          branch_model.Data b,
                                        ) {
                                          return DropdownMenuItem<String>(
                                            value: b.branchCode,
                                            child: Text(
                                              b.branchName ?? '',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                height: 1.0,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                    onChanged: (value) async {
                                  
                                      setState(() => selectedBranch = value);
                                  
                                      final token = await storage.read(
                                        key: 'access_Token',
                                      );
                                      final companyCode = await storage.read(
                                        key: 'company_Code',
                                      );
                                  
                                      if (token != null && companyCode != null) {
                                        final dates = getDateRange(dropdownValue);
                                  
                                        context.read<AdminhomeBloc>().add(
                                          FetchtotalsaleEvent(
                                            token: token,
                                            companyCode: companyCode,
                                            branch: value, 
                                          ),
                                        );
                                        print('value = $value');
                                        if (value != null && value.isNotEmpty) {
                                          context.read<AdminclosereportBloc>().add(
                                          FetchClosingBranchReportEvent(
                                            token: token,
                                            companyCode: companyCode,
                                            startDate: dates['startDate']!,
                                            endDate: dates['endDate']!,
                                            branch: value
                                          ),
                                          );
                                        }
                                        else {
                                          context.read<AdminclosereportBloc>().add(
                                            FetchClosingReportEvent(
                                              token: token,
                                              companyCode: companyCode,
                                              startDate: dates['startDate']!,
                                              endDate: dates['endDate']!,
                                            ),
                                          );
                                        }
                                        
                                        context.read<AdmingraphBloc>().add(
                                          FetchSalesGraphEvent(
                                            token: token,
                                            companyCode: companyCode,
                                            branch: value
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
                BlocBuilder<AdminhomeBloc, AdminhomeState>(
                  builder: (context, state) {
                    if (state is AdmintotalsaleLoading) {
                      return Container(
                        width: 366.w,
                        height: 182.h,
                        decoration: ShapeDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.65, 0.77),
                            end: Alignment(0.02, 0.01),
                            colors: [
                              const Color(0xFFC307A5),
                              const Color(0xFF822BA8),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (state is AdmintotalsaleError) {
                      return Container(
                        width: 366.w,
                        height: 182.h,
                        decoration: ShapeDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.65, 0.77),
                            end: Alignment(0.02, 0.01),
                            colors: [
                              const Color(0xFFC307A5),
                              const Color(0xFF822BA8),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Center(child: Text('Failed to load data')),
                      );
                    }
                    if (state is AdmintotalsaleLoaded) {
                      final totalSale = state.totalSale;
                      totalCount = state.totalCount;
                      companyDetails = state.companyDetails;
                      return Column(
                        children: [
                          Container(
                            width: 366.w,
                            // height: 182.h,
                            decoration: ShapeDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(0.65, 0.77),
                                end: Alignment(0.02, 0.01),
                                colors: [
                                  const Color(0xFFC307A5),
                                  const Color(0xFF822BA8),
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              companyDetails.currencyCode!
                                                  .split(' ')[1]
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.sp,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              totalSale.toString(),
                                              maxLines: 1,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 35.sp,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w500,
                                                // letterSpacing: 1.60,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SvgPicture.asset('assets/Chart.svg'),
                                    ],
                                  ),
                                  SizedBox(height: 16.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Total Order',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            totalCount.results!.orderCount
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Customers',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            totalCount.results!.customerCount
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Employees',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            totalCount.results!.employeeCount
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                BlocBuilder<AdminclosereportBloc, AdminclosereportState>(
                  builder: (context, state) {
                    if (state is AdminClosingReportLoading) {
                      return Container(
                        width: 366.w,
                        height: 188.h,
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
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (state is AdminClosingReportError) {
                      return Container(
                        width: 366.w,
                        height: 188.h,
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
                        child: Center(child: Text('Failed to load data')),
                      );
                    }
                    if (state is AdminClosingReportLoaded) {
                      closingReport = state.closingReport;
                      return Column(
                        children: [
                          SizedBox(height: 24.h),
                          Container(
                            width: 366.w,
                            // height: 184,
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
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        closingReport.totalGrossSale.toString(),
                                        style: TextStyle(
                                          color: const Color(0xFF150A33),
                                          fontSize: 18.sp,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 81.w,
                                        // height: 36.h,
                                        child: DropdownButtonFormField<String>(
                                          value: dropdownValue,
                                          isExpanded: true,
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 18.sp,
                                          ),
                                          isDense: true,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 8.w,
                                                  vertical: 6.h,
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(21.6),
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(21.6),
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          items:
                                              range.map((item) {
                                                return DropdownMenuItem(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: TextStyle(
                                                      color: const Color(
                                                        0xFF949494,
                                                      ),
                                                      fontSize: 11.sp,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 2.63,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                );
                                              }).toList(),
                                          onChanged: (value) async {
                                            setState(() {
                                              dropdownValue = value!;
                                            });
                                            final dates = getDateRange(value!);

                                            final token = await storage.read(
                                              key: 'access_Token',
                                            );
                                            final companyCode = await storage
                                                .read(key: 'company_Code');

                                            if (token != null &&
                                                companyCode != null) {
                                                  // if (selectedBranch!.isEmpty) {
                                                    context
                                                  .read<AdminclosereportBloc>()
                                                  .add(
                                                    FetchClosingReportEvent(
                                                      token: token,
                                                      companyCode: companyCode,
                                                      startDate:
                                                          dates['startDate']!,
                                                      endDate:
                                                          dates['endDate']!,
                                                    ),
                                                  );
                                                  // }
                                                  // else {
                                                  //   context.read<AdminclosereportBloc>().add(
                                                  //   FetchClosingBranchReportEvent(
                                                  //     token: token,
                                                  //     companyCode: companyCode,
                                                  //     startDate: dates['startDate']!,
                                                  //     endDate: dates['endDate']!,
                                                  //     branch: value
                                                  //   ),
                                                  //   );
                                                  // }
                                              
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Total Sale',
                                    style: TextStyle(
                                      color: const Color(0xFF514A6B),
                                      fontSize: 14.sp,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 18.h),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Wrap(
                                      spacing: 12.w,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Discount',
                                              style: TextStyle(
                                                color: const Color(0xFF514A6B),
                                                fontSize: 12.sp,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              closingReport.totalDiscount
                                                  .toString(),
                                              style: TextStyle(
                                                color: const Color(0xFF5D5FEF),
                                                fontSize: 16.sp,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Commission',
                                              style: TextStyle(
                                                color: const Color(0xFF514A6B),
                                                fontSize: 12.sp,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              closingReport.totalCommission
                                                  .toString(),
                                              style: TextStyle(
                                                color: const Color(0xFF00C8F4),
                                                fontSize: 16.sp,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Expenses',
                                              style: TextStyle(
                                                color: const Color(0xFF514A6B),
                                                fontSize: 12.sp,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              (closingReport.totalExpense! -
                                                      closingReport
                                                          .totalCommission!
                                                          .toInt())
                                                  .toString(),
                                              style: TextStyle(
                                                color: const Color(0xFFFF9228),
                                                fontSize: 16.sp,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Pending',
                                              style: TextStyle(
                                                color: const Color(0xFF514A6B),
                                                fontSize: 12.sp,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              closingReport.debtamount.toString(),
                                              style: TextStyle(
                                                color: const Color(0xFFEA0000),
                                                fontSize: 16.sp,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Outstanding',
                                              style: TextStyle(
                                                color: const Color(0xFF514A6B),
                                                fontSize: 12.sp,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              closingReport.outstandingamount
                                                  .toString(),
                                              style: TextStyle(
                                                color: const Color(0xFFEA0000),
                                                fontSize: 16.sp,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    if (state is AdminClosingBranchReportLoaded) {
                      closingReport = state.closingReport;
                      return Column(
                        children: [
                          SizedBox(height: 24.h),
                          Container(
                            width: 366,
                            // height: 184,
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
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        closingReport.totalGrossSale.toString(),
                                        style: TextStyle(
                                          color: const Color(0xFF150A33),
                                          fontSize: 18.sp,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 81.w,
                                        height: 36.h,
                                        child: DropdownButtonFormField<String>(
                                          value: dropdownValue,
                                          isExpanded: true,
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 18.sp,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 8.w,
                                                  vertical: 6.h,
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(21.6),
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(21.6),
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          items:
                                              range.map((item) {
                                                return DropdownMenuItem(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: TextStyle(
                                                      color: const Color(
                                                        0xFF949494,
                                                      ),
                                                      fontSize: 11.sp,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 2.63,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                );
                                              }).toList(),
                                          onChanged: (value) async {
                                            setState(() {
                                              dropdownValue = value!;
                                            });
                                            final dates = getDateRange(value!);

                                            final token = await storage.read(
                                              key: 'access_Token',
                                            );
                                            final companyCode = await storage
                                                .read(key: 'company_Code');

                                            if (token != null &&
                                                companyCode != null) {
                                                  
                                                    context.read<AdminclosereportBloc>().add(
                                                    FetchClosingBranchReportEvent(
                                                      token: token,
                                                      companyCode: companyCode,
                                                      startDate: dates['startDate']!,
                                                      endDate: dates['endDate']!,
                                                      branch: selectedBranch
                                                    ),
                                                    );
                                                  
                                              
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Total Sale',
                                    style: TextStyle(
                                      color: const Color(0xFF514A6B),
                                      fontSize: 14.sp,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 18.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Discount',
                                            style: TextStyle(
                                              color: const Color(0xFF514A6B),
                                              fontSize: 12.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            closingReport.totalDiscount
                                                .toString(),
                                            style: TextStyle(
                                              color: const Color(0xFF5D5FEF),
                                              fontSize: 16.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Commission',
                                            style: TextStyle(
                                              color: const Color(0xFF514A6B),
                                              fontSize: 12.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            closingReport.totalCommission
                                                .toString(),
                                            style: TextStyle(
                                              color: const Color(0xFF00C8F4),
                                              fontSize: 16.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Expenses',
                                            style: TextStyle(
                                              color: const Color(0xFF514A6B),
                                              fontSize: 12.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            (closingReport.totalExpense! -
                                                    closingReport
                                                        .totalCommission!
                                                        .toInt())
                                                .toString(),
                                            style: TextStyle(
                                              color: const Color(0xFFFF9228),
                                              fontSize: 16.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Pending',
                                            style: TextStyle(
                                              color: const Color(0xFF514A6B),
                                              fontSize: 12.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            closingReport.debtamount.toString(),
                                            style: TextStyle(
                                              color: const Color(0xFFEA0000),
                                              fontSize: 16.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Outstanding',
                                            style: TextStyle(
                                              color: const Color(0xFF514A6B),
                                              fontSize: 12.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            closingReport.outstandingamount
                                                .toString(),
                                            style: TextStyle(
                                              color: const Color(0xFFEA0000),
                                              fontSize: 16.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                SizedBox(height: 25.h),
                BlocBuilder<AdmingraphBloc, AdmingraphState>(
                  builder: (context, state) {
                    if (state is AdmingraphLoading) {
                      return Container(
                        width: 366.w,
                        height: 235.h,
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
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (state is AdmingraphError) {
                      return Container(
                        width: 366.w,
                        height: 235.h,
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
                        child: Center(child: Text('Failed to load data')),
                      );
                    }
                    if (state is AdmingraphLoaded) {
                      return Column(
                        children: [
                          Container(
                            width: 366.w,

                            // height: 235.h,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Sales',
                                      style: TextStyle(
                                        color: const Color(0xFF484848),
                                        fontSize: 16.sp,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 19.h),
                                Container(
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: MonthlySalesChart(
                                      data: state.salesGraph,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
