import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syswash/bloc/bloc/clothdetails_bloc.dart';
import 'package:syswash/bloc/bloc/customerlist_bloc.dart';
import 'package:syswash/bloc/bloc/deliverystatus_bloc.dart';
import 'package:syswash/bloc/bloc/devicetoken_bloc.dart';
import 'package:syswash/bloc/bloc/home_bloc.dart';
import 'package:syswash/bloc/bloc/login_bloc.dart';
import 'package:syswash/bloc/bloc/pickupcustdetails_bloc.dart';
import 'package:syswash/bloc/bloc/pickuplist_bloc.dart';
import 'package:syswash/bloc/bloc/profile_bloc.dart';
import 'package:syswash/bloc/bloc/servicedetails_bloc.dart';
import 'package:syswash/bloc/bloc/settings_bloc.dart';
import 'package:syswash/bloc/bloc/uploadpickup_bloc.dart';
import 'package:syswash/firebase_options.dart';
import 'package:syswash/screens/login.dart';
import 'package:syswash/screens/splash.dart';




Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(" Background message: ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Needed for Firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => PickuplistBloc()),
        BlocProvider(create: (context) => CustomerlistBloc()),
        BlocProvider(create: (context) => PickupcustdetailsBloc()),
        BlocProvider(create: (context) => UploadpickupBloc()),
        BlocProvider(create: (context) => ClothdetailsBloc()),
        BlocProvider(create: (context) => ServicedetailsBloc()),
        BlocProvider(create: (context) => SettingsBloc()),
        BlocProvider(create: (context) => DeliverystatusBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(create: (context) => DevicetokenBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initFCM();
  }



  Future<void> _initFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print("🔔 Notification permission status: ${settings.authorizationStatus}");
    
    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("📩 Foreground message received: ${message.notification?.title}");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      
    });

    // When app opened from notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("🟢 App opened via notification: ${message.notification?.title}");
    });

    // Token refresh
    // FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    //   print("♻️ Token refreshed: $newToken");
    //   context.read<DevicetokenBloc>().add(SaveDeviceToken(newToken));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 932),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          scaffoldBackgroundColor: const Color(0xFFF8F8F8),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
