import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCategoryCard extends StatelessWidget {
  final String name, img;
  final Function() press;
  const CustomCategoryCard(
      {Key? key, required this.name, required this.img, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: press,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.2,
          child: ClipRRect(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Flexible(
                child: CircleAvatar(
                    radius: 30,
                    backgroundImage: CachedNetworkImageProvider(img)),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(fontSize: 12)),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
