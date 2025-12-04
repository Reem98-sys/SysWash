import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syswash/bloc/bloc/profile_bloc.dart';
import 'package:syswash/screens/editProfile.dart';
import 'package:syswash/screens/password_dialog.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? token;
  String? companyCode;
  String? userId;
  Future<void> getUserData() async {
    const storage = FlutterSecureStorage();
    final tokenAccess = await storage.read(key: 'access_Token');
    final companycode = await storage.read(key: 'company_Code');
    final userid = await storage.read(key: 'login_id');
    setState(() {
      token = tokenAccess;
      companyCode = companycode;
      userId = userid;
    });
    if (userId != null && companyCode != null && token != null) {
      context.read<ProfileBloc>().add(
        FetchProfileEvent(
          userId: userId ?? '',
          companyCode: companyCode ?? '',
          token: token ?? '',
        ),
      );
    } else {
      debugPrint('Missing userId or companyCode in storage');
    }
  }

  @override
  void initState() {
    super.initState();
    // Call it when screen loads
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            // Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_sharp),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileBlocLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ProfileBlocError) {
                return Center(
                  child: Text(
                    'Failed to load orders\n',
                    style: TextStyle(color: Colors.red, fontSize: 14.sp),
                  ),
                );
              }
              if (state is ProfileBlocLoaded) {
                final profileData = state.profileModel;
                return Column(
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
                      profileData.name.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      profileData.mobile.toString(),
                      style: TextStyle(
                        color: const Color(0xFF6E6F79),
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => Editprofile(
                                  name: profileData.name.toString(),
                                  email: profileData.email.toString(),
                                  phoneno: profileData.mobile.toString(),
                                  gender: profileData.gender.toString(),
                                  location: profileData.address.toString(),
                                  password: profileData.password.toString(),
                                ),
                          ),
                        );
                        if (result == true) {
                          getUserData();
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
                                Icons.phone_in_talk,
                                color: const Color(0xFF68188B),
                              ),
                            ),
                          ),
                          Text(
                            profileData.mobile.toString(),
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
                                Icons.person_rounded,
                                color: const Color(0xFF68188B),
                              ),
                            ),
                          ),
                          Text(
                            profileData.gender.toString(),
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
                                Icons.location_on,
                                color: const Color(0xFF68188B),
                              ),
                            ),
                          ),
                          Text(
                            profileData.address.toString(),
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
                            onTap: () {
                              showEditPasswordDialog(context,profileData.password!);
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
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
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
