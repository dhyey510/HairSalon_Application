import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hairsalon_application/Models/SalonModel.dart';
import 'package:hairsalon_application/Models/SalonUser.dart';
import 'package:hairsalon_application/Screens/loading_screen.dart';
import 'package:hairsalon_application/Screens/salondetail_screen.dart';
import 'package:hairsalon_application/Services/auth.dart';
import 'package:hairsalon_application/Services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hairsalon_application/Widgets/AllSalonCard.dart';
import 'package:hairsalon_application/Widgets/NearbySalonCard.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static final String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService auth = AuthService();

  TextEditingController _textController = TextEditingController();

  late List<Salon> nearbySalons;

  late List<Salon> allSalons;

//fetch salons function
  fetchNearbySalons() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization":
          'Bearer ${dotenv.env['YELP_API']}',
    };

    String location = "CA";

    Stream<SalonUser> user =
        DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
            .getcurrentUser;

    return user.first.then((value) async {
      location = value.address;

      final url = Uri.parse(
          'https://api.yelp.com/v3/businesses/search?location=${location}&categories=hair&locale=en_US&sort_by=best_match&limit=10');

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var salonModel = SalonModel.fromJson(jsonDecode(response.body));
        nearbySalons = salonModel.salons;
        return salonModel.salons;
      } else {
        print("Error Not Fetching Data");
      }
    });
  }

  fetchAllSalons() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization":
          'Bearer ${dotenv.env['YELP_API']}',
    };

    String location = "US";

    final url = Uri.parse(
        'https://api.yelp.com/v3/businesses/search?location=${location}&categories=hair&locale=en_US&sort_by=best_match&limit=10');

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var salonModel = SalonModel.fromJson(jsonDecode(response.body));
      allSalons = salonModel.salons;
      return salonModel.salons;
    } else {
      print("Error Not Fetching Data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SalonUser>(
        stream: DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).getcurrentUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            SalonUser? user;
            user = snapshot.data;
            var names = user!.name.split(' ');

            return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Profile & Search box (Black Section)
                    Container(
                      margin: EdgeInsets.only(top: 55, left: 18, right: 18),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Profile Section
                          Container(
                            margin: EdgeInsets.only(bottom: 55),
                            child: Row(
                              children: [
                                //image
                                Container(
                                  width: 75,
                                  height: 75,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: ClipRRect(
                                    child: user.profileImg != null? Image.network(
                                      user.profileImg,
                                      fit: BoxFit.cover,
                                    ):Image.asset('assets/images/profilePhoto.jpg', fit: BoxFit.cover,),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                ),
              
                                //name & address
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Hi, ${names[0]}!",
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.white.withOpacity(0.61),
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            user!.address,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white
                                                    .withOpacity(0.61)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
              
                          //Search Box
                          CupertinoSearchTextField(
                            controller: _textController,
                            itemColor: Colors.white60,
                            placeholder: "Search by name..",
                            style: TextStyle(color: Colors.white),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              border:
                                  Border.all(color: Colors.white60, width: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
              
                    // for Main Icons (White)
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                          color: Color(0xffECEEF3),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 15, bottom: 10),
                                  child: Text(
                                    "Nearby Salons",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
              
                                Container(
                                  height: 180,
                                  child: FutureBuilder(
                                      future: fetchNearbySalons(),
                                      builder: (context, AsyncSnapshot snapshot) {
                                        if (snapshot.hasError) {
                                          print(snapshot.data);
                                        }
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.black,
                                              backgroundColor: Color(0xfff4f4f4),
                                            ),
                                          );
                                        } else {
                                          return ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                itemCount: nearbySalons.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets.only(right: 8.0),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => SalonDetailScreen(salon: nearbySalons[index],)));
                                                      },
                                                      child: NearbySalonCard(
                                                        name:
                                                            nearbySalons[index].name,
                                                        imageurl: nearbySalons[index]
                                                            .imageUrl,
                                                        index: index,
                                                        address: nearbySalons[index]
                                                                .city +
                                                            ", " +
                                                            nearbySalons[index].state,
                                                        rating: nearbySalons[index]
                                                            .rating,
                                                      ),
                                                    ),
                                                  );
                                                });
                                        }
                                      }),
                                ),
              
                                //All Salons
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 25, bottom: 10),
                                  child: Text(
                                    "All Salons",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
              
                                Container(
                                  height: 300,
                                  child: FutureBuilder(
                                      future: fetchAllSalons(),
                                      builder: (context, AsyncSnapshot snapshot) {
                                        if (snapshot.hasError) {
                                          print(snapshot.data);
                                        }
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.black,
                                              backgroundColor: Color(0xfff4f4f4),
                                            ),
                                          );
                                        } else {
                                          return GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 5.0,
                                              crossAxisSpacing: 15.0,
                                            ),
                                            padding: EdgeInsets.only(bottom: 25.0, top: 10),
                                            itemCount: allSalons.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SalonDetailScreen(salon: allSalons[index],)));
                                                },
                                                child: AllSalonCard(
                                                    name: allSalons[index].name,
                                                    imageurl:
                                                        allSalons[index].imageUrl,
                                                    index: index,
                                                    address: allSalons[index].city + ", " + allSalons[index].state,
                                                    rating: allSalons[index].rating,
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      }),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            );
          } else {
            return LoadingScreen();
          }
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNearbySalons();
    fetchAllSalons();
  }
}
