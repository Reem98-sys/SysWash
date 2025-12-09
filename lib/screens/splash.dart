import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syswash/screens/login.dart';
import 'package:syswash/screens/bottomnav.dart'; // your home page
import 'package:syswash/bloc/bloc/devicetoken_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 1)); // for splash delay

    final userId = await storage.read(key: 'login_id');
    final companyCode = await storage.read(key: 'company_Code');
    final accessToken = await storage.read(key: 'access_Token');

    if (userId != null && accessToken != null && companyCode != null) {
      //  Re-init device token sync after restart
      // final deviceToken = await FirebaseMessaging.instance.getToken();
      // if (deviceToken != null) {
      //   BlocProvider.of<DevicetokenBloc>(context).add(
      //     FetchDeviceTokenEvent(
      //       userID: userId,
      //       companyCode: companyCode,
      //       token: accessToken,
      //       devicetoken: deviceToken,
      //     ),
      //   );
      // }

      // Navigate directly to home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Bottomnav()),
      );
    } else {
      // Navigate to login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
