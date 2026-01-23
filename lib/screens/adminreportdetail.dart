import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syswash/bloc/bloc/adminhome_bloc.dart';

class Adminreportdetail extends StatefulWidget {
  const Adminreportdetail({super.key});

  @override
  State<Adminreportdetail> createState() => _AdminreportdetailState();
}

class _AdminreportdetailState extends State<Adminreportdetail> {
  final storage = const FlutterSecureStorage();
  String? username;
  @override
  void initState() {
    super.initState();
    _loadAndFetchData();
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
      context.read<AdminhomeBloc>().add(
        FetchcompanyEvent(token: token, companyCode: companyCode),
      );
    } else {
      debugPrint('Missing userId or companyCode in storage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          child: Column(
            children: [
              Container(
                width: 362.w,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Order Report',
                          style: TextStyle(
                            color: const Color(0xFF150A33),
                            fontSize: 16.sp,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: 362.w,
                      height: 230.h,
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
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Table(
                            border: TableBorder.all(
                              color: const Color(0xFFE7E7E7),
                              width: 1,
                            ),
                            children: [
                              TableRow(
                                children: [
                                  _tableText( 'Total Amount'),
                                  _tableValue('1234')
                                ],
                              ),
                              TableRow(
                                children: [
                                  _tableText( 'Total Discount'),
                                  _tableValue('1234')
                                ],
                              ),
                              TableRow(
                                children: [
                                  _tableText( 'Total Paid'),
                                  _tableValue('1234')
                                ],
                              ),
                              TableRow(
                                children: [
                                  _tableText( 'Total Balance'),
                                  _tableValue('1234')
                                ],
                              ),
                              TableRow(
                                children: [
                                  _tableText( 'Total Commission'),
                                  _tableValue('1234')
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
              SizedBox(
                height: 21.h,
              ),
              Container(
                width: 362.w,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Account Wise',
                          style: TextStyle(
                            color: const Color(0xFF150A33),
                            fontSize: 16.sp,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: 362.w,
                      height: 230.h,
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
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Table(
                            border: TableBorder.all(
                              color: const Color(0xFFE7E7E7),
                              width: 1,
                            ),
                            children: [
                              TableRow(
                                children: [
                                  _tableText( 'WML'),
                                  _tableValue('1234')
                                ],
                              ),
                              TableRow(
                                children: [
                                  _tableText( 'QSERVE'),
                                  _tableValue('1234')
                                ],
                              ),
                              TableRow(
                                children: [
                                  _tableText( 'ALDOBI'),
                                  _tableValue('1234')
                                ],
                              ),
                              TableRow(
                                children: [
                                  _tableText( 'CR.(WALKIN)'),
                                  _tableValue('1234')
                                ],
                              ),
                              TableRow(
                                children: [
                                  _tableText( 'WALK IN CASH'),
                                  _tableValue('1234')
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
          ),
        ),
      ),
    );
  }
}

Widget _tableText(String data) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(15,10,15,10),
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
    padding: const EdgeInsets.fromLTRB(15,10,15,10),
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
