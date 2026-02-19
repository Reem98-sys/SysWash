import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:syswash/bloc/bloc/adminbranch_bloc.dart';
import 'package:syswash/bloc/bloc/adminclosereport_bloc.dart';
import 'package:syswash/bloc/bloc/admingraph_bloc.dart';
import 'package:syswash/bloc/bloc/adminhome_bloc.dart';
import 'package:syswash/bloc/bloc/adminprofile_bloc.dart';

import 'package:syswash/bloc/bloc/clothdetails_bloc.dart';
import 'package:syswash/bloc/bloc/customerlist_bloc.dart';
import 'package:syswash/bloc/bloc/deliverystatus_bloc.dart';
import 'package:syswash/bloc/bloc/devicetoken_bloc.dart';
import 'package:syswash/bloc/bloc/forgotpass_bloc.dart';
import 'package:syswash/bloc/bloc/home_bloc.dart';
import 'package:syswash/bloc/bloc/login_bloc.dart';
import 'package:syswash/bloc/bloc/pickupcustdetails_bloc.dart';
import 'package:syswash/bloc/bloc/pickuplist_bloc.dart';
import 'package:syswash/bloc/bloc/profile_bloc.dart';
import 'package:syswash/bloc/bloc/report_bloc.dart';
import 'package:syswash/bloc/bloc/reportlist_bloc.dart';
import 'package:syswash/bloc/bloc/servicedetails_bloc.dart';
import 'package:syswash/bloc/bloc/settings_bloc.dart';
import 'package:syswash/bloc/bloc/uploadpickup_bloc.dart';

import 'package:syswash/firebase_options.dart';
import 'package:syswash/model/adminBranch.dart';
import 'package:syswash/screens/login.dart';
import 'package:syswash/screens/splash.dart';


// --------------------------------------------------------------------
// BACKGROUND HANDLER
// --------------------------------------------------------------------
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("📨 Background message: ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    OverlaySupport.global(          //Required for in-app banner
      child: MultiBlocProvider(
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
          BlocProvider(create: (context) => ForgotpassBloc()),
          BlocProvider(create: (context) => AdminhomeBloc()),
          BlocProvider(create: (context) => AdminclosereportBloc()),
          BlocProvider(create: (context) => AdmingraphBloc()),
          BlocProvider(create: (context) => ReportBloc()),
          BlocProvider(create: (context) => ReportlistBloc()),
          BlocProvider(create: (context) => AdminprofileBloc()),
          BlocProvider(create: (context) => AdminbranchBloc()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}


// --------------------------------------------------------------------
// APP ROOT
// --------------------------------------------------------------------
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FlutterLocalNotificationsPlugin localNoti;

  @override
  void initState() {
    super.initState();
    _initFCM();
  }

  Future<void> _initFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // ---------------------------------------------------------------
    // LOCAL NOTIFICATIONS INITIALIZATION
    // ---------------------------------------------------------------
    localNoti = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
        InitializationSettings(android: androidInit);

    await localNoti.initialize(initSettings);

    // ---------------------------------------------------------------
    // PERMISSION REQUEST
    // ---------------------------------------------------------------
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      sound: true,
    );

    print("🔔 Permission: ${settings.authorizationStatus}");

    // ---------------------------------------------------------------
    // FOREGROUND NOTIFICATION → SHOW IN-APP BANNER
    // ---------------------------------------------------------------
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final title = message.notification?.title ?? "New Notification";
      final body = message.notification?.body ?? "";

      print("📩 Foreground message: $title");

      // ---------------------------------------------------------
      // ALSO SHOW SYSTEM NOTIFICATION (OPTIONAL)
      // ---------------------------------------------------------
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        'default_channel',
        'Default Notifications',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );

      const NotificationDetails notiDetails =
          NotificationDetails(android: androidDetails);

      await localNoti.show(0, title, body, notiDetails);
    });

    // ---------------------------------------------------------------
    // USER OPENED APP FROM NOTIFICATION
    // ---------------------------------------------------------------
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("🟢 App opened by notification: ${message.notification?.title}");
    });
  }

  // ----------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 932),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SysWash',
        
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFF8F8F8),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFFF8F8F8), // AppBar background
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
