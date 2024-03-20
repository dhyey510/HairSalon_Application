import 'package:flutter/foundation.dart';
import 'package:hairsalon_application/Models/AppointmentModel.dart';

class SalonUser{
  String name = '';
  String email = '';
  String contactNumber = '';
  String gender = '';
  String address = '';
  String password = '';
  String profileImg = '';
  List<AppointmentModel> appointment = [];

  SalonUser({
    this.name = '',
    this.email = '',
    this.contactNumber = '',
    this.address = '',
    this.password = '',
    this.gender = '',
    this.profileImg = ''
    // this.appointment = const [],
  });


  void updateUser(SalonUser user) {
    this.address = user.address;
    this.name = user.name;
    this.contactNumber = user.contactNumber;
    this.email = user.email;
    this.gender = user.gender;
    this.appointment = user.appointment;
    this.profileImg = user.profileImg;
  }

}
