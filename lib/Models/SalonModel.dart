import 'dart:ffi';

import 'package:flutter/foundation.dart';

class SalonModel {
  List<Salon> salons;
  int total;

  SalonModel({
    required this.salons,
    required this.total,
  });

  factory SalonModel.fromJson(Map<String, dynamic> json) => SalonModel(
    salons: List<Salon>.from(json["businesses"].map((x) => Salon.fromJson(x))),
    total: json["total"],
  );
}

class Salon{
  String id = '';
  String name = '';
  String contactNumber = '';
  String address = '';
  String city ='';
  String state = '';
  String imageUrl = '';
  bool isClose = false;
  double rating = 0;
  List<dynamic> photos = [];

  Salon({
    this.id = "",
    this.name = "",
    this.contactNumber = '',
    this.address = '',
    this.city ='',
    this.state = '',
    this.imageUrl = '',
    this.isClose = false,
    this.rating = 0,
    this.photos = const [],
  });

  factory Salon.fromJson(Map<String, dynamic> json) => Salon(
    id: json["id"],
    name: json["name"],
    imageUrl: json["image_url"],
    isClose: json["hours"] != null ? !json["hours"][0]["is_open_now"] : false,
    photos: json['photos'] != null ? json['photos'] : [],
    rating: json["rating"]?.toDouble(),
    address: json["location"]["address1"],
    city: json["location"]["city"],
    state: json["location"]["state"],
    contactNumber: json["display_phone"]
  );

}
