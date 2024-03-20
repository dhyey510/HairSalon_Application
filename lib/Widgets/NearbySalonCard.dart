import 'package:flutter/material.dart';

class NearbySalonCard extends StatelessWidget {
  final String name;
  final String imageurl;
  final int index;
  final String address;
  final double rating;

  const NearbySalonCard({
    Key? key,
    required this.name,
    required this.imageurl,
    required this.index,
    required this.address,
    required this.rating,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //salon image
              Container(
                width: 250,
                height: 90,
                child: ClipRRect(
                  child: Image.network(
                    imageurl,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
              ),

              //Name & star
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 180,
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Color(0xffffd233),
                          size: 15,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          rating.toString(),
                          style: TextStyle(
                              color: Color(0xffffd233), fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //Location
              Padding(
                padding: const EdgeInsets.only(top: 2, bottom: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
