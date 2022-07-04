import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/Components/custom_icons.dart';

class CustomProductCard extends StatelessWidget {
  final Map product;
  final Function() press;
  const CustomProductCard({Key? key, required this.product, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.5,
        child: ClipRRect(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Expanded(
              child: Image(
                  image: CachedNetworkImageProvider(product['Images'][0])),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Text(product['Name'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(fontSize: 11))),
                      Text('₹ ${product['Price']}',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold))
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('4.5'),
                          Icon(Icons.star, color: Colors.green, size: 15)
                        ],
                      ),
                      Icon(Icons.favorite_outline, color: Colors.red)
                    ],
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
