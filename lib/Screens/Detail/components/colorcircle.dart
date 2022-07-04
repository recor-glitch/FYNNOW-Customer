import 'package:flutter/material.dart';

class ColorCircle extends StatelessWidget {
  const ColorCircle(
      {Key? key,
      required this.press,
      required this.colour,
      required this.isclicked})
      : super(key: key);
  final Function() press;
  final Color colour;
  final bool isclicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
            border: isclicked
                ? Border.all(color: Color.fromARGB(255, 76, 210, 228), width: 3)
                : Border.all(color: Colors.grey.shade300, width: 2)),
        child: Container(
            margin: EdgeInsets.all(3),
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.height * 0.04,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: colour,
                border: Border.all(color: Colors.grey.shade300))),
      ),
    );
  }
}
