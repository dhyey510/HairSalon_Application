import 'package:flutter/material.dart';
import 'package:hairsalon_application/Models/AppointmentModel.dart';
import 'package:hairsalon_application/Models/SalonModel.dart';
import 'package:hairsalon_application/Screens/appointment_done_screen.dart';
import 'package:hairsalon_application/Screens/dashboard_Screen.dart';
import 'package:hairsalon_application/Screens/editprofile_screen.dart';
import 'package:hairsalon_application/Screens/history_screen.dart';
import 'package:hairsalon_application/Screens/home_screen.dart';
import 'package:hairsalon_application/Screens/info_screen.dart';
import 'package:hairsalon_application/Screens/login_screen.dart';
import 'package:hairsalon_application/Screens/notification_screen.dart';
import 'package:hairsalon_application/Screens/prediction_screen.dart';
import 'package:hairsalon_application/Screens/profile_screen.dart';
import 'package:hairsalon_application/Screens/salondetail_screen.dart';
import 'package:hairsalon_application/Screens/signup_screen.dart';
import 'package:hairsalon_application/Screens/style_screen.dart';
import 'package:hairsalon_application/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: "lib/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: Wrapper(),
      routes: {
        LoginScreen.id:(context) => LoginScreen(),
        SignUpScreen.id:(context) => SignUpScreen(),
        DashBoardScreen.id : (context) => DashBoardScreen(),
        HomeScreen.id : (context) => HomeScreen(),
        ProfileScreen.id:(context) => ProfileScreen(),
        StyleScreen.id : (context) => StyleScreen(),
        SalonDetailScreen.id: (context) => SalonDetailScreen(salon: Salon()),
        AppointmentDoneScreen.id : (context) => AppointmentDoneScreen(apt: AppointmentModel()),
        HistoryScreen.id: (context) => HistoryScreen(),
        NotificationScreen.id : (context) => NotificationScreen(),
        PredictionScreen.id : (context) => PredictionScreen(),
        EditProfileScreen.id : (context) => EditProfileScreen(),
        InfoScreen.id : (context) => InfoScreen(),
      },
    );
  }
}
