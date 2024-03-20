import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hairsalon_application/Models/AppointmentModel.dart';
import 'package:hairsalon_application/Models/SalonModel.dart';
import 'package:hairsalon_application/Models/SalonUser.dart';
import 'package:hairsalon_application/Screens/appointment_done_screen.dart';
import 'package:hairsalon_application/Screens/loading_screen.dart';
import 'package:hairsalon_application/Services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hairsalon_application/Widgets/RoundedButton.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class SalonDetailScreen extends StatefulWidget {
  Salon salon;

  SalonDetailScreen({
    key,
    required this.salon,
  }) : super(key: key);

  static final String id = "SalonDetailScreen";

  @override
  State<SalonDetailScreen> createState() => _SalonDetailScreenState();
}

class _SalonDetailScreenState extends State<SalonDetailScreen> {
  List<String> list = <String>['Haircut', 'Haircolor', 'Waxing', 'NailArt'];

  String dropdownValue = "Haircut";
  DateTime date = DateTime(1900);

  fetchDetailsOfSalons() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization":
          "Bearer PLuiYmQESOSSiAxEWbmMBoGj6GC3t8nQyHYXYUZI8-J4bX6CpPOh6LayLg-s7zlO5A7eeEOVPr4UM1w6cK5gTJdAR-_JbN1Wk2ZfMxMeivJ9T8uRBheGLC-9ruZRZHYx",
    };

    final url =
        Uri.parse('https://api.yelp.com/v3/businesses/${widget.salon.id}');

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var salonModel = Salon.fromJson(jsonDecode(response.body));
      widget.salon = salonModel;
      return salonModel;
    } else {
      print("Error Not Fetching Data");
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController datectrl = TextEditingController();

    return StreamBuilder<SalonUser>(
        stream: DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
            .getcurrentUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            SalonUser? user = snapshot.data;

            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                backgroundColor: Colors.black,
              ),
              body: SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Color(0xffeceef3),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25)),
                  ),
                  child: FutureBuilder(
                      future: fetchDetailsOfSalons(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              backgroundColor: Color(0xfff4f4f4),
                            ),
                          );
                        } else {
                          return Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //image
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.30,
                                  child: FlutterCarousel(
                                    options: CarouselOptions(
                                        viewportFraction: 1.0,
                                        showIndicator: true,
                                        autoPlay: true,
                                        autoPlayInterval: Duration(seconds: 3),
                                        autoPlayCurve: Curves.linear,
                                        slideIndicator: CircularSlideIndicator(),
                                        height: MediaQuery.of(context).size.height,),
                                    items: widget.salon.photos.map((i) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Container(
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                                                child: Image.network(
                                                  i,
                                                  fit: BoxFit.fill,
                                                  width: MediaQuery.of(context).size.width,
                                                  height: MediaQuery.of(context).size.height,
                                                )),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),

                                //details
                                SingleChildScrollView(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height * 0.57,
                                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    padding: EdgeInsets.all(10),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          //Name & star
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 280,
                                                  child: Text(
                                                    widget.salon.name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    softWrap: false,
                                                    style: TextStyle(
                                                        fontSize: 23,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: Color(0xffffd233),
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Text(
                                                      widget.salon.rating
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),

                                          //Location
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 3),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: Color(0xffaaaaaa),
                                                  size: 18,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  widget.salon.address +
                                                      ", " +
                                                      widget.salon.city +
                                                      ", " +
                                                      widget.salon.state,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Color(0xffaaaaaa),
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ],
                                            ),
                                          ),

                                          //timing
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 3),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.access_time_sharp,
                                                  color: Color(0xffaaaaaa),
                                                  size: 18,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  widget.salon.isClose
                                                      ? "Closed Now"
                                                      : "Open Now",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color:
                                                          widget.salon.isClose
                                                              ? Colors.red
                                                              : Colors.green,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ],
                                            ),
                                          ),

                                          //divider
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Divider(
                                              color: Color(0xffaaaaaa),
                                              thickness: 1,
                                            ),
                                          ),

                                          //services
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0),
                                            child: Container(
                                              height: 95,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Services",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18),
                                                  ),
                                                  Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                      ),
                                                      child:
                                                          DropdownButtonFormField<
                                                              String>(
                                                        hint: Text(
                                                            'Select Service'),
                                                        value: dropdownValue,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Colors.black,
                                                            fontSize: 15),
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            dropdownValue =
                                                                newValue!;
                                                          });
                                                        },
                                                        items: list.map<
                                                            DropdownMenuItem<
                                                                String>>((String
                                                            value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),

                                          //date
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 25.0),
                                            child: Container(
                                              height: 95,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Select Date",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18),
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    child: TextFormField(
                                                      onTap: () async {
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                new FocusNode());
                                                        date =
                                                            (await showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    DateTime
                                                                        .now(),
                                                                firstDate:
                                                                    DateTime
                                                                        .now(),
                                                                lastDate:
                                                                    DateTime(
                                                                        2100)))!;

                                                        datectrl.text = date.year.toString() +
                                                            "-" +
                                                            date.month.toString() +
                                                            "-" +
                                                            date.day.toString();
                                                      },
                                                      controller: datectrl,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: Colors.black,
                                                          fontSize: 15),
                                                      decoration:
                                                          InputDecoration(
                                                        suffixIcon: Icon(
                                                          Icons.calendar_month,
                                                          color:
                                                              Color(0xffaaaaaa),
                                                          size: 18,
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            "Appointment Date",
                                                        hintStyle: TextStyle(
                                                            color: Color(
                                                                0xffaaaaaa)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          //book button
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 40.0, bottom: 10),
                                            child: RoundedButton(
                                              padding: EdgeInsets.all(0),
                                              onPressed: () {
                                                AppointmentModel temp = AppointmentModel(
                                                  imageUrl: widget.salon.imageUrl,
                                                  id: widget.salon.id,
                                                  state: widget.salon.state,
                                                  city: widget.salon.city,
                                                  name: widget.salon.name,
                                                  address: widget.salon.address,
                                                  appointmentDate: date.toString()
                                                );
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AppointmentDoneScreen(apt: temp,)));
                                                },
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w400),
                                              title: "Book Appointment",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      }),
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
    fetchDetailsOfSalons();
  }
}
