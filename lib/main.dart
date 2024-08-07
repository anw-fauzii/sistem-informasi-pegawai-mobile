import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:belajar_flutter/controllers/authentication.dart';
import 'package:belajar_flutter/controllers/user_controller.dart';
import 'package:belajar_flutter/pages/login_page.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting('id_ID', null);
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi GetStorage
  await GetStorage.init();

  // Inisialisasi notifikasi
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Inisialisasi timezone
  tz.initializeTimeZones();

  // Jadwalkan notifikasi
  _scheduleDailyNotification(flutterLocalNotificationsPlugin);

  // Inisialisasi controller
  Get.put(UserController());
  Get.put(AuthenticationController());

  runApp(const MyApp());
}

Future<void> _scheduleDailyNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'daily_notification_channel_id',
    'Daily Notifications',
    'Channel for daily notifications',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);

  try {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Daily Reminder',
      'This is your daily reminder notification.',
      _nextInstanceOfFivePM(), // Fungsi untuk mendapatkan waktu berikutnya jam 5 sore
      notificationDetails,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  } catch (e) {
    print('Error scheduling notification: $e');
  }
}

tz.TZDateTime _nextInstanceOfFivePM() {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  final tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, 17);
  if (scheduledDate.isBefore(now)) {
    return scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: "SIPegawai",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      defaultTransition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 400),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
