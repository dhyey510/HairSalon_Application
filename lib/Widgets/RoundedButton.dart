import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final EdgeInsets padding;
  final TextStyle style;

  const RoundedButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.style = const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
    ),
    this.padding = const EdgeInsets.all(15.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        elevation: 0.0,
        padding: EdgeInsets.all(15.0),
        color: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () => onPressed(),
        child: Text(
          title,
          style: style
        ),
      ),
    );
  }
}
