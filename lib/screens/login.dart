import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syswash/bloc/bloc/login_bloc.dart';
import 'package:syswash/model/loginModel.dart';
import 'package:syswash/screens/bottomnav.dart';
import 'package:syswash/screens/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController companyCode = TextEditingController();
  bool? checkValue = false;
  bool _obscurePassword = true; // Track password visibility
  late LoginModel loginModel;
  final storage = FlutterSecureStorage();
  Future<void> saveLoginId(String userId,String companyCode,String token,String username) async {
  await storage.write(key: 'login_id', value: userId);
  await storage.write(key: 'company_Code', value: companyCode);
  await storage.write(key: 'access_Token', value: token);
  await storage.write(key: 'user_name', value: username);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 113.h),
            Image.asset('assets/icon.png', width: 77.w, height: 77.h),
            SizedBox(height: 34.h),
            // Text(
            //       "SYSWASH",
            //       style: TextStyle(
            //         fontSize: 28,
            //         fontWeight: FontWeight.bold,
            //         foreground: Paint()
            //           ..shader = const LinearGradient(
            //             colors: [Color(0xff7340F2), Color(0xffD029BE)],
            //           ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
            //       ),
            //     ),
            Text(
              'Welcome Back',
              style: TextStyle(
                color: const Color(0xFF0D0140),
                fontSize: 30.sp,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 50.h),
            Container(
              width: 317.w,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Company Code',
                        style: TextStyle(
                          color: const Color(0xFF0D0140),
                          fontSize: 16.sp,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: 317.w,
                    height: 50.h,
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
                      controller: companyCode,
                      decoration: InputDecoration(
                        // contentPadding: EdgeInsets.all(5),
                        border: InputBorder.none,
                        hintText: 'Enter company code',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15.h),

            Container(
              width: 317.w,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                          color: const Color(0xFF0D0140),
                          fontSize: 16.sp,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: 317.w,
                    height: 50.h,
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
                        // contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                        hintText: 'Enter Email',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            Container(
              width: 317.w,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Password',
                        style: TextStyle(
                          color: const Color(0xFF0D0140),
                          fontSize: 16.sp,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: 317.w,
                    height: 50.h,
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
                      controller: passwordController,
                      obscureText: _obscurePassword, //  Apply the boolean
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                        border: InputBorder.none,
                        hintText: 'Enter Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscurePassword =
                                  !_obscurePassword; // toggle on tap
                            });
                          },
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  // Checkbox(
                  //   value: checkValue,
                  //   onChanged: (bool? value) {
                  //     setState(() {
                  //       checkValue = value;
                  //     });
                  //   },
                  // ),
                  // Text(
                  //   'Remember me',
                  //   style: TextStyle(
                  //     color: const Color(0xFFA9A5B8),
                  //     fontSize: 12.sp,
                  //     fontFamily: 'DM Sans',
                  //     fontWeight: FontWeight.w400,
                  //   ),
                  // ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password ?',
                      style: TextStyle(
                        color: const Color(0xFF0D0140),
                        fontSize: 12,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            BlocListener<LoginBloc,LoginState>(
              listener: (context, state) {
                if (state is LoginBlocLoading) {
                  showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },);
                }
                if (state is LoginBlocError) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,)
                    );
                }
                if (state is LoginBlocLoaded) {
                  Navigator.pop(context);
                  loginModel = BlocProvider.of<LoginBloc>(context).loginModel;
                  print(loginModel.id.toString());
                  saveLoginId(loginModel.id.toString(),companyCode.text.trim(),loginModel.access.toString(),loginModel.username.toString());
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Bottomnav()));
                }
              
              },
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<LoginBloc>(context).add(FetchLoginEvent(email: emailController.text.trim(), password: passwordController.text.trim(), companyCode: companyCode.text.trim()));

                },
                child: Container(
              width: 317.w,
              height: 50.h,
              decoration: ShapeDecoration(
                color: const Color(0xFF68188B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                shadows: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.84,
                  ),
                ),
              ),
            ),
              ),),
            
          ],
        ),
      ),
    );
  }
}
