import 'package:flutter/material.dart';
import 'package:hairsalon_application/Screens/dashboard_Screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Screens/login_screen.dart';

class Wrapper extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return Center(child: CircularProgressIndicator());
        }
        User? user = FirebaseAuth.instance.currentUser;
        if (user!= null){
          // FirebaseAuth.instance.currentUser.emailVerified == true) {
          print("user is logged in");
          // print(user);
          print(user.email);
          return DashBoardScreen();

        } else {
          print("user is not logged in");
          return LoginScreen();
        }
      },
    );

  }
}
