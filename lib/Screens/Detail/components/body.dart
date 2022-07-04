import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/Bloc%20Provider/product_detail/quantity_cubit.dart';
import 'package:myapp/Components/customsnackbar.dart';
import 'package:myapp/Infrastructure/cartfcade.dart';
import 'package:myapp/Models/productmodel.dart';
import 'package:myapp/Provider/colour_provider.dart';
import 'package:myapp/Provider/size_provider.dart';
import 'package:myapp/Screens/Detail/components/colorcircle.dart';
import 'package:myapp/Screens/Detail/components/customcontainer.dart';
import 'package:myapp/Screens/Detail/components/customsellercard.dart';
import 'package:myapp/Screens/Detail/components/expanddesc.dart';
import 'package:myapp/Screens/Detail/components/product_image.dart';
import 'package:myapp/Screens/Detail/components/selectseller.dart';
import 'package:myapp/Screens/Detail/components/sizecontainer.dart';
import 'package:myapp/Screens/Home/components/heading.dart';
import 'package:myapp/constants.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  final ProductModel product;
  const Body({Key? key, required this.product}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int quantity = 1;
  int selected_color = 0;
  int selected_size = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        ProductImages(product: widget.product),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('₹ ${widget.product.price}',
                          style: GoogleFonts.roboto(
                              fontSize: 25, color: textcolor)),
                      Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('4.5',
                                  style: GoogleFonts.roboto(fontSize: 20)),
                              Icon(Icons.star, color: Colors.green, size: 20)
                            ],
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Icon(Icons.favorite, color: Colors.red, size: 30)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ExpandedDesc(desc: widget.product.desc),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  widget.product.colours.isNotEmpty
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            custom_divider,
                            Heading(name: 'Select Colour : '),
                            ChangeNotifierProvider(
                              create: (BuildContext context) =>
                                  ColourProvider(),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: widget.product.colours.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Consumer<ColourProvider>(builder:
                                          (BuildContext context, value, child) {
                                        selected_color = value.colourindex;
                                        return ColorCircle(
                                            press: () {
                                              value.ChangeColour(index);
                                            },
                                            colour: Color.fromRGBO(
                                                int.parse(widget.product
                                                    .colours[index]['r']),
                                                int.parse(widget.product
                                                    .colours[index]['g']),
                                                int.parse(widget.product
                                                    .colours[index]['b']),
                                                1),
                                            isclicked:
                                                value.colourindex == index);
                                      });
                                    }),
                              ),
                            )
                          ],
                        )
                      : Container(),
                  widget.product.sizes.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            custom_divider,
                            Heading(name: 'Select Size : '),
                            ChangeNotifierProvider(
                              create: (BuildContext context) => SizeProvider(),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: widget.product.sizes.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Consumer<SizeProvider>(builder:
                                          (BuildContext context, sizeprovider,
                                              child) {
                                        selected_size = sizeprovider.sizeindex;
                                        return SizeContainer(
                                            size: widget.product.sizes[index],
                                            press: () {
                                              sizeprovider.ChangeSize(index);
                                            },
                                            isclicked: sizeprovider.sizeindex ==
                                                index);
                                      });
                                    }),
                              ),
                            )
                          ],
                        )
                      : Container(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Column(
                    children: [
                      custom_divider,
                      Heading(name: 'Quantity : '),
                      BlocBuilder<QuantityCubit, QuantityState>(
                        builder: (context, countstate) {
                          if (countstate is QuantityInitial) {
                            return Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    BlocProvider.of<QuantityCubit>(context)
                                        .DecrementCount(countstate.count);
                                    quantity = countstate.count;
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.grey.shade400)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(Icons.remove,
                                          color: Color.fromRGBO(55, 53, 53, 1),
                                          size: 30),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 9, horizontal: 10),
                                  child: Text(countstate.count.toString(),
                                      style: GoogleFonts.roboto(fontSize: 20)),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey.shade400)),
                                  child: InkWell(
                                      onTap: () {
                                        quantity = countstate.count + 1;
                                        BlocProvider.of<QuantityCubit>(context)
                                            .IncrementCount(countstate.count);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Icon(Icons.add,
                                            color:
                                                Color.fromRGBO(55, 53, 53, 1),
                                            size: 30),
                                      )),
                                )
                              ],
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  custom_divider,
                  SelectSeller(press: () async {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('New',
                                      style: TextStyle(fontSize: 20))),
                              CustomSellerCard(
                                  price: '2000', seller: 'Rajo Store'),
                              CustomSellerCard(
                                  price: '1599', seller: 'Sarathi Store')
                            ],
                          );
                        });
                  }),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  CustomContainer(
                      press: () {
                        Navigator.pushNamed(context, '/checkout', arguments: [
                          {
                            'price': widget.product.price,
                            'name': widget.product.name,
                            'img': widget.product.img,
                            'desc': widget.product.desc,
                            'brand': widget.product.brand,
                            'sizes': widget.product.sizes,
                            'colour': widget.product.colours.isNotEmpty
                                ? widget.product.colours[selected_color]
                                : null,
                            'quantity': quantity,
                            'size': widget.product.sizes.isNotEmpty
                                ? widget.product.sizes[selected_size]
                                : null,
                            'colours': widget.product.colours
                          }
                        ]);
                      },
                      value: 'Buy Now',
                      colour: Color.fromRGBO(226, 51, 72, 1),
                      style: GoogleFonts.roboto(fontSize: 20),
                      border: BorderSide.none),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  CustomContainer(
                      press: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(milliseconds: 400),
                            behavior: SnackBarBehavior.floating,
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            content: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade900),
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text('Adding to Cart'),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2))
                                    ],
                                  ),
                                ))));
                        CartFcade fcade = CartFcade();
                        fcade.AddToCart({
                          'price': widget.product.price,
                          'name': widget.product.name,
                          'img': widget.product.img,
                          'desc': widget.product.desc,
                          'brand': widget.product.brand,
                          'sizes': widget.product.sizes,
                          'colour': widget.product.colours.isNotEmpty
                              ? widget.product.colours[selected_color]
                              : null,
                          'quantity': quantity,
                          'size': widget.product.sizes.isNotEmpty
                              ? widget.product.sizes[selected_size]
                              : null,
                          'colours': widget.product.colours
                        });
                        CustomSnackbar('Added to Cart.', context,
                            time: Duration(milliseconds: 400));
                      },
                      value: 'Add to Cart',
                      colour: Colors.white,
                      style: GoogleFonts.roboto(
                          color: Color.fromRGBO(226, 51, 72, 1), fontSize: 20),
                      border: BorderSide(
                          color: Color.fromRGBO(226, 51, 72, 1), width: 1))
                ]),
          ),
        )
      ]),
    );
  }
}
