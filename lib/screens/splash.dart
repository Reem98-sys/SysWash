import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

    try {
      userId = await storage.read(key: 'login_id').timeout(const Duration(seconds: 2));
      companyCode = await storage.read(key: 'company_Code').timeout(const Duration(seconds: 2));
      accessToken = await storage.read(key: 'access_Token').timeout(const Duration(seconds: 2));
      userType = await storage.read(key: 'user_Type').timeout(const Duration(seconds: 2));
    } catch (e) {
      debugPrint('Secure storage error : $e');
    }
    

    if (!mounted) return;

    if (userId != null && companyCode != null && accessToken != null && userType != null) {

      // ✅ Optional: re-sync device token (safe version)
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

      if (userType == 'Driver') {
        //  Navigate to driver home
        Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Bottomnav()),
      );
      }  
      else {
        //  Navigate to admin home
        Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Bottomnavadmin()),
      );
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
