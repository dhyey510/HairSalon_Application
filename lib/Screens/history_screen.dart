import 'package:flutter/material.dart';
import 'package:hairsalon_application/Models/SalonUser.dart';
import 'package:hairsalon_application/Screens/loading_screen.dart';
import 'package:hairsalon_application/Services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  static final String id = "HistoryScreen";

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SalonUser>(
        future:  DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).currentUser(),
        builder: (context, snapshot){
          if(snapshot.hasData){

            SalonUser? user = snapshot.data;

            return Scaffold(
              appBar: AppBar(
                title: Text("History", style: TextStyle(color: Colors.white),),
                backgroundColor: Colors.black,
                iconTheme: IconThemeData(color: Colors.white),
              ),
              body: ListView.builder(
                itemCount: user!.appointment.length,
                itemBuilder: (context, index) {

                  DateTime date = DateTime.parse(user.appointment[index].appointmentDate);

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [

                              //image
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                      child: Image.network(
                                        user.appointment[index].imageUrl,
                                        height: 100.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),

                              //details
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [

                                      //name
                                      Text(
                                        user.appointment[index].name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),

                                      //date
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2, bottom: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.calendar_month,
                                              color: Color(0xffaaaaaa),
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              date.year.toString() +"-" + date.month.toString() +"-" + date.day.toString(),
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //status
                                      Center(
                                        child: DateTime.parse(user.appointment[index].appointmentDate).isBefore(DateTime.now())?
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5.0, horizontal: 10.0),
                                          margin: EdgeInsets.symmetric(vertical: 5.0),
                                          decoration: BoxDecoration(
                                            color: Color(0xffE6EFFF),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child:Text(
                                            'Done',
                                            style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 14,
                                            ),
                                          )
                                        ): Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.0, horizontal: 10.0),
                                            margin: EdgeInsets.symmetric(vertical: 5.0),
                                            decoration: BoxDecoration(
                                              color: Color(0xffD9FAF6),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child:Text(
                                              'Upcoming',
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 14,
                                              ),
                                            )
                                        ),
                                      ),
                                    ]),
                              ),
                            ],
                          ),

                          //cancel button
                          Center(
                            child: IconButton(
                              color: Color(0xffFBDAE3),
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                int indx = user.appointment.indexOf(user.appointment[index]);
                                user.appointment.removeAt(indx);
                                DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).updateUserData(user);
                                setState(() {});
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }else{
            return LoadingScreen();
          }
        });
  }
}
