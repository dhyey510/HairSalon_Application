import 'package:flutter/material.dart';
import 'package:hairsalon_application/Screens/history_screen.dart';

class GridItem extends StatelessWidget {
  final String title;
  final String icon;
  final int index;
  final String route;

  const GridItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.index,
    this.route='',
    // required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(route);
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
              child: Image.asset(icon, width: 20, height: 20,),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
