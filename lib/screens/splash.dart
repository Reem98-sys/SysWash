import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

    final String? userId = await storage.read(key: 'login_id');
    final String? companyCode = await storage.read(key: 'company_Code');
    final String? accessToken = await storage.read(key: 'access_Token');

    if (!mounted) return;

    if (userId != null && companyCode != null && accessToken != null) {

      // ✅ Optional: re-sync device token (safe version)
      try {
        final String? deviceToken =
            await FirebaseMessaging.instance.getToken();

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

      // ✅ Navigate to home
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Bottomnav()),
      );
    } else {
      // ✅ Navigate to login
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
