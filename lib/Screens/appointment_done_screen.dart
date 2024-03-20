import 'package:flutter/material.dart';
import 'package:hairsalon_application/Models/AppointmentModel.dart';
import 'package:hairsalon_application/Models/SalonUser.dart';
import 'package:hairsalon_application/Screens/loading_screen.dart';
import 'package:hairsalon_application/Services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';

class AppointmentDoneScreen extends StatefulWidget {
  AppointmentModel apt;

  AppointmentDoneScreen({
    key,
    required this.apt
  }) : super(key: key);

  static final String id = "AppointmentDoneScreen";

  @override
  State<AppointmentDoneScreen> createState() => _AppointmentDoneScreenState();
}

class _AppointmentDoneScreenState extends State<AppointmentDoneScreen> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SalonUser>(
        future: DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).currentUser(),
        builder: (context, snapshot){
          if(snapshot.hasData){

            SalonUser? user = snapshot.data;

            user!.appointment.add(widget.apt);

            DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).updateUserData(user);

            return Scaffold(
              appBar: AppBar(
                title: Text("Confirmation"),
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      height: 300,
                      child: FlareActor(
                        "assets/images/Success Check.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text("Appointment Done", style: TextStyle(fontSize: 25),),
                  ],
                ),
              ),
            );
          }else{
            return LoadingScreen();
          }
        }
    );
  }


}
