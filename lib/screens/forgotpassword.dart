import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syswash/bloc/bloc/forgotpass_bloc.dart';
import 'package:syswash/screens/resetpassword.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () =>  Navigator.pop(context),
          child: Icon(Icons.arrow_back)),
        title: Padding(
          padding: const EdgeInsets.only(left: 60.0),
          child: Text('Forgot Password'),
        ),  
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.h,),
            Center(
              child: Container(
                    width: 317.w,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Column(
                      children: [
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
                            controller: codeController,
                            decoration: InputDecoration(
                              // contentPadding: EdgeInsets.all(10),
                              border: InputBorder.none,
                              hintText: 'Enter company code',
                            ),
                          ),
                        ),
                      ],
                    ),),
                        
                      ],
                    ),
                  ),
            ),
            SizedBox(height: 15.h,),
            Center(
              child: Container(
                    width: 317.w,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Column(
                      children: [
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
                    ),),
                        
                      ],
                    ),
                  ),
            ),
            SizedBox(height: 20.h,),
            BlocListener<ForgotpassBloc,ForgotpassState>(
              listener: (context, state) {
                if (state is ForgotpassLoading) {
                  showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(child: CircularProgressIndicator());
                        },
                      );
                }
                if (state is ForgotpassError) {
                  Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                }
                if (state is ForgotpassLoaded) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Resetpassword(companyCode: codeController.text,)),
                        );
                }
              },
              child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<ForgotpassBloc>(context).add(
                      FetchForgotEvent(
                        companyCode: codeController.text.trim(), 
                        email: emailController.text.trim())
                    );
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
                            'Submit',
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
                ),)
                
          ],
        ),
      ),
    );
  }
}