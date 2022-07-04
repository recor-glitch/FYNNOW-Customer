import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Models/productmodel.dart';
import 'package:myapp/Screens/Detail/components/small_reference_image.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  late CarouselController controller;

  @override
  void initState() {
    controller = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider.builder(
            carouselController: controller,
            itemCount: widget.product.img.length,
            itemBuilder: (BuildContext context, int index, int realIndex) =>
                CachedNetworkImage(imageUrl: widget.product.img[index]),
            options: CarouselOptions(
                onPageChanged: ((index, reason) {
                  setState(() {
                    selectedImage = index;
                  });
                }),
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                height: MediaQuery.of(context).size.height * 0.4),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.product.img.length,
              itemBuilder: (BuildContext context, int index) {
                return smallReferenceImage(
                  asset: widget.product.img[index],
                  isclicked: index == selectedImage,
                  press: () {
                    controller.animateToPage(index);
                    setState(() {
                      selectedImage = index;
                    });
                  },
                );
              }),
        )
      ],
    );
  }
}
