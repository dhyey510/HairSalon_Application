import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  static final String id = "infoScreen";

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Info", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Made By: ", style: TextStyle(fontSize: 18),),
              SizedBox(height: 25,),
              CircleAvatar(radius: 70, child: Image.asset('assets/images/logo_final_final.png'), backgroundColor: Colors.black,),
              SizedBox(height: 15,),
              Text("HairSim", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Container(
                    width: 300,
                    child: Text("An AI integrated application where use can tryout different hairstyle with this application.", style: TextStyle(fontSize: 18, color: Color(0xffA5A5A5)), softWrap: true, textAlign: TextAlign.center,)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => _launchUrl('tel: +11234567890'),
                      child: CircleAvatar(
                          radius: 25.0,
                          backgroundColor: Colors.blue.shade100,
                          child: Icon(
                            Icons.phone,
                            size: 30.0,
                            color: Colors.blue.shade900,
                          )),
                    ),
                    SizedBox(width: 35,),
                    GestureDetector(
                      onTap: () =>
                          _launchUrl('mailto: hairsim@info.com'),
                      child: CircleAvatar(
                          radius: 25.0,
                          backgroundColor: Colors.yellow.shade100,
                          child: Icon(
                            Icons.email_rounded,
                            size: 30.0,
                            color: Colors.yellow.shade900,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
