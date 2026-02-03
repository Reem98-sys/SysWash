import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syswash/bloc/bloc/adminprofile_bloc.dart';
import 'package:syswash/helper/date_helper.dart';
import 'package:syswash/screens/adminEditProfile.dart';
import 'package:syswash/screens/admin_pass_dialog.dart';
import 'package:syswash/screens/bottomnavAdmin.dart';
import 'package:syswash/screens/login.dart';

class Adminprofile extends StatefulWidget {
  const Adminprofile({super.key});

  @override
  State<Adminprofile> createState() => _AdminprofileState();
}

class _AdminprofileState extends State<Adminprofile> {
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
      context.read<AdminprofileBloc>().add(
        FetchAdminProfile(
          token: token,
          companyCode: companyCode,
          userId: userId,
        ),
      );
    } else {
      debugPrint('Missing userId or companyCode in storage');
    }
  }

  Future<void> _signOut(BuildContext context) async {
    const storage = FlutterSecureStorage();

    // Clear stored user data
    await storage.deleteAll();

    // Optional: show confirmation toast
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Signed out successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    // Navigate back to login screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Bottomnavadmin(currentIndex: 1,))),
          child: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: Center(
          child: Text(
            'Profile',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: BlocBuilder<AdminprofileBloc, AdminprofileState>(
        builder: (context, state) {
          if (state is AdminProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state is AdminProfileError) {
            return Center(
              child: Text(
                'Failed to load orders\n',
                style: TextStyle(color: Colors.red, fontSize: 14.sp),
              ),
            );
          }
          if (state is AdminProfileLoaded) {
            final profileData = state.adminProfile;
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 39.h),
                    Container(
                      width: 106,
                      height: 106,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/icon.png'),
                          fit: BoxFit.cover,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(height: 19.h),
                    Text(
                      profileData.userName.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              
                    SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => Admineditprofile(
                                  name: profileData.userName.toString(),
                                  email: profileData.email.toString(),
                                ),
                          ),
                        );
                        if (result == true) {
                          _loadAndFetchData();
                        }
                      },
                      child: Container(
                        width: 168.w,
                        height: 60.h,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFE2E5F4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit_outlined,
                              color: const Color(0xFF68188B),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Edit Profile',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      width: 362.w,
                      height: 60.h,
                      decoration: ShapeDecoration(
                        color: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: 42.w,
                              height: 42.h,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFE2E5F4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Icon(
                                Icons.mail,
                                color: const Color(0xFF68188B),
                              ),
                            ),
                          ),
                          Text(
                            profileData.email.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: 362.w,
                      height: 60.h,
                      decoration: ShapeDecoration(
                        color: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: 42.w,
                              height: 42.h,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFE2E5F4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Icon(
                                Icons.date_range,
                                color: const Color(0xFF68188B),
                              ),
                            ),
                          ),
                          Text(
                            formatOrderDate(
                              profileData.userCreatedDate,
                            ).toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
              
                    SizedBox(height: 8.h),
                    Container(
                      width: 362.w,
                      height: 60.h,
                      decoration: ShapeDecoration(
                        color: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: 42.w,
                              height: 42.h,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFE2E5F4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Icon(
                                Icons.visibility_rounded,
                                color: const Color(0xFF68188B),
                              ),
                            ),
                          ),
                          Text(
                            '********',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () async {
                              final result = await adminshowEditPasswordDialog(
                                context,
                              );
                              if (result == true) {
                                // Only refresh if password updated successfully
                                _loadAndFetchData();
                              }
                            },
                            child: Icon(
                              Icons.edit_outlined,
                              color: const Color(0xFF68188B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                title: const Text(
                                  'Sign Out',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: const Text(
                                  'Are you sure you want to sign out?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed:
                                        () => Navigator.pop(context, false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, true),
                                    child: const Text(
                                      'Sign Out',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                        );
              
                        if (confirm == true) {
                          await _signOut(context);
                        }
                      },
                      child: Container(
                        width: 362.w,
                        height: 60.h,
                        decoration: ShapeDecoration(
                          color: Colors.grey[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                width: 42.w,
                                height: 42.h,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFE2E5F4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Icon(
                                  Icons.login_outlined,
                                  color: const Color(0xFF68188B),
                                ),
                              ),
                            ),
                            Text(
                              'Sign Out',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios_sharp),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
