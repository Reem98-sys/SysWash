import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syswash/helper/verifytoken.dart';
import 'package:syswash/screens/bottomnavAdmin.dart';
import 'package:syswash/screens/login.dart';
import 'package:syswash/screens/bottomnav.dart';
import 'package:syswash/bloc/bloc/devicetoken_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    // Wait until first frame is rendered before navigation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkLoginStatus();
    });
  }

  Future<void> checkLoginStatus() async {
    // Splash delay
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    String? userId;
    String? companyCode;
    String? accessToken;
    String? userType;
    String? refreshtoken;

    try {
      userId = await storage.read(key: 'login_id').timeout(const Duration(seconds: 2));
      companyCode = await storage.read(key: 'company_Code').timeout(const Duration(seconds: 2));
      accessToken = await storage.read(key: 'access_Token').timeout(const Duration(seconds: 2));
      userType = await storage.read(key: 'user_Type').timeout(const Duration(seconds: 2));
      refreshtoken = await storage.read(key: 'refresh_token').timeout(const Duration(seconds: 2));
    } catch (e) {
      debugPrint('Secure storage error : $e');
    }
    

    if (!mounted) return;

    if (userId != null && companyCode != null && accessToken != null && userType != null) {
      String? newToken = await AuthService.refreshAccessToken(refreshtoken!); 

      if (newToken == null) {
    // 2. Refresh failed (Session truly dead) -> Clear and Login
          await storage.deleteAll();
          if (!mounted) return;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const Login())
          );
          return;
        }
        else {
      if (userType == 'Driver') {
      
              // Optional: re-sync device token (safe version)
              try {
                final String? deviceToken =
                    await FirebaseMessaging.instance.getToken().timeout(const Duration(seconds: 3));
      
                if (deviceToken != null && mounted) {
                  context.read<DevicetokenBloc>().add(
                        FetchDeviceTokenEvent(
                          userID: userId,
                          companyCode: companyCode,
                          token: accessToken,
                          devicetoken: deviceToken,
                        ),
                      );
                }
              } catch (e) {
                debugPrint('Device token error: $e');
              } 
              
              //  Navigate to driver home
              Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const Bottomnav()),
            );
            }  
            else {
              // try {
              //   final String? deviceToken =
              //       await FirebaseMessaging.instance.getToken().timeout(const Duration(seconds: 3));
      
              //   if (deviceToken != null && mounted) {
              //     context.read<DevicetokenBloc>().add(
              //           FetchAdminDeviceTokenEvent(
              //             userID: userId,
              //             companyCode: companyCode,
              //             token: accessToken,
              //             devicetoken: deviceToken,
              //           ),
              //         );
              //   }
              // } catch (e) {
              //   debugPrint('Device token error: $e');
              // }
              
              //  Navigate to admin home
              Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const Bottomnavadmin()),
            );
            }
        }
      
      
    } else {
      //  Navigate to login
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Image.asset(
          'assets/splashscreen.png',
          width: 350.w,
          height: 70.h,)
      ),
    );
  }
}
