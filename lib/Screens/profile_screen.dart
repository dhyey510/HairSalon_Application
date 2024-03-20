import 'package:flutter/material.dart';
import 'package:hairsalon_application/Models/SalonUser.dart';
import 'package:hairsalon_application/Screens/editprofile_screen.dart';
import 'package:hairsalon_application/Screens/history_screen.dart';
import 'package:hairsalon_application/Screens/info_screen.dart';
import 'package:hairsalon_application/Screens/loading_screen.dart';
import 'package:hairsalon_application/Screens/login_screen.dart';
import 'package:hairsalon_application/Screens/notification_screen.dart';
import 'package:hairsalon_application/Services/auth.dart';
import 'package:hairsalon_application/Services/database.dart';
import 'package:hairsalon_application/Widgets/GridItem.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static final String id = "ProfileScreen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  AuthService auth = AuthService();

  void logOut() async {
    await auth.signout();
    SnackBar snackBar = SnackBar(
      content: Text(
        'Logout successful',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16.0),
      ),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.popAndPushNamed(context, LoginScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SalonUser>(
        stream: DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).getcurrentUser,
        builder: (context, snapshot) {
          if(snapshot.hasData){

            SalonUser? user;
            user = snapshot.data;
            var names=user!.name.split(' ');

            return Container(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                fit: StackFit.loose,
                children: [
                  // profile short
                  Positioned(
                    top: 0,
                    right: 1,
                    left: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.30,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Hi ${names[0]}",
                                style: TextStyle(fontSize: 30, color: Colors.white),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on, color: Colors.white.withOpacity(0.61),),
                                  SizedBox(width: 5,),
                                  Text(
                                    "${user.address}",
                                    style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.61)),
                                  ),
                                ],
                              )
                            ],
                          ),
                          user.profileImg != null?
                            CircleAvatar(radius: 40, backgroundImage: NetworkImage(user.profileImg)):
                            CircleAvatar(radius: 40, backgroundImage: AssetImage('assets/images/profilePhoto.jpg')),
                        ],
                      ),
                    ),
                  ),

                  // SizedBox(height: 20,),
                  // for Main Icons
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                        color: Color(0xffECEEF3),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.64,
                      child: GridView.count(
                        crossAxisCount: 3,
                        padding: EdgeInsets.only(top: 20, bottom: 20, left: 7, right: 7),
                        children: [
                          GridItem(
                            title: "History",
                            icon: "assets/images/history.png",
                            index: 0,
                            route: HistoryScreen.id, //PrincipalDeskScreen.id
                          ),
                          GridItem(
                            title: "Notification",
                            icon: "assets/images/notification.png",
                            route: NotificationScreen.id, //AttendanceScreen.id
                            index: 1,
                          ),
                          GridItem(
                            title: "Profile",
                            icon: "assets/images/profile.png",
                            index: 2,
                            route: EditProfileScreen.id, //RemarkScreen.id
                          ),
                          GridItem(
                            title: "Info",
                            icon: "assets/images/InfoIcon.png",
                            index: 3,
                            route: InfoScreen.id, //ResultSelect.id
                          ),
                          GestureDetector(
                            onTap: () {
                              logOut();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white
                              ),
                              width: 50,
                              height: 50,
                              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    child: Image.asset("assets/images/logout.png", width: 20, height: 20,),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Logout",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                              ],
                            ),
                          ),
                        ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }else{
            return LoadingScreen();
          }
        }
    );
  }
}
