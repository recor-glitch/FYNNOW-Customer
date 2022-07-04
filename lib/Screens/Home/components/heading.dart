import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Heading extends StatelessWidget {
  final String name;
  const Heading({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(name,
              style: GoogleFonts.openSans(
                  fontWeight: FontWeight.bold, fontSize: 20))
        ],
      ),
    );
  }
}
