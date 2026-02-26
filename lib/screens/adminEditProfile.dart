import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syswash/bloc/bloc/adminprofile_bloc.dart';

class Admineditprofile extends StatefulWidget {
  final String name;
  final String email;
  const Admineditprofile({
    super.key,
    required this.name,
    required this.email,
    });

  @override
  State<Admineditprofile> createState() => _AdmineditprofileState();
}

class _AdmineditprofileState extends State<Admineditprofile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? token;
  String? companyCode;
  String? userId;
  Future<void> _updateProfileData(
    String name,
    String email,
  ) async {
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
      context.read<AdminprofileBloc>().add(
        UpdateAdminProfileEvent(
          userID: userId ?? '',
          token: token ?? '',
          companyCode: companyCode ?? '',
          userName: name,
          email: email,
        ),
      );
    } else {
      debugPrint('Missing userId or companyCode in storage');
    }
  }
  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    emailController.text = widget.email;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_sharp),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocListener<AdminprofileBloc,AdminprofileState>(
        listener: (context, state) async {
          if (state is UpdateProfileLoaded) {
            const storage = FlutterSecureStorage();

            await storage.write(key: 'user_name', value: nameController.text);
            await storage.write(key: 'email', value: emailController.text);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile updated successfully!'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.pop(context, true);
          }
          if (state is AdminProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to update profile'),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 352.w,
                    // height: 80.h,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(
                                color: const Color(0xFF150A33),
                                fontSize: 16.sp,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Container(
                          width: 352.w,
                          // height: 50.h,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              // contentPadding: EdgeInsets.all(5),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: 352.w,
                    // height: 80.h,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                color: const Color(0xFF150A33),
                                fontSize: 16.sp,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Container(
                          width: 352.w,
                          // height: 50.h,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              // contentPadding: EdgeInsets.all(5),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  
                  
                  SizedBox(height: 30.h),
                  GestureDetector(
                    onTap: () {
                      _updateProfileData(
                        nameController.text,
                        emailController.text
                      );
                    },
                    child: Container(
                      width: 352,
                      height: 50,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF68188B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x2D99AAC5),
                            blurRadius: 62,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'SAVE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.84,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),),
    );
  }
}