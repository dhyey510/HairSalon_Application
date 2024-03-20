import 'dart:ffi';

import 'package:flutter/material.dart';

class AllSalonCard extends StatelessWidget {
  final String name;
  final String imageurl;
  final int index;
  final String address;
  final double rating;

  const AllSalonCard({
    Key? key,
    required this.name,
    required this.imageurl,
    required this.index,
    required this.address,
    required this.rating,
  }): super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //salon image
          Container(
            width: double.maxFinite,
            height: 90,
            child: ClipRRect(
              child: Image.network(
                imageurl,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)),
            ),
          ),

          //Name & star
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              width: 120,
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),

          //Location
          Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 5),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Color(0xffaaaaaa),
                  size: 15,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  address,
                  style: TextStyle(
                      fontSize: 13,
                      color: Color(0xffaaaaaa),
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
