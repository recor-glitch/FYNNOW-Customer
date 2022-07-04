import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/Bloc%20Provider/cart/cart_cubit.dart';
import 'package:myapp/Bloc%20Provider/selectattribute/selectattribute_cubit.dart';
import 'package:myapp/Models/productmodel.dart';
import 'package:myapp/Screens/Cart/components/customtextfield.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);
  TextEditingController controller = TextEditingController();
  String? error;
  var selected_attribute;

  @override
  Widget build(BuildContext context) {
    Widget EditDeliveryAddress(BuildContext modalcontext) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Wrap(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Change Delivery Address',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              IconButton(
                  onPressed: () {
                    Navigator.pop(modalcontext);
                  },
                  icon: Icon(Icons.close))
            ]),
            Divider(
                color: Colors.grey.shade200,
                indent: 0,
                endIndent: 0,
                thickness: 5),
            CustomPincodeField(
                controller: controller, modalcontext: modalcontext),
            Container(
                width: MediaQuery.of(modalcontext).size.width,
                height: MediaQuery.of(context).size.height * 0.05,
                color: Colors.grey.shade200,
                child: Center(
                    child: Text('OR',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey)))),
            InkWell(
              onTap: () {},
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(modalcontext).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                      child: Text('ADD NEW ADDRESS',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(226, 51, 72, 1))))),
            )
          ],
        ),
      );
    }

    Widget DeliveryAddress() {
      return Card(
        margin: EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(TextSpan(text: 'Deliver to:', children: [
                          TextSpan(text: 'Rishi Sarmah'),
                          TextSpan(text: '781020')
                        ])),
                        Text('Geetanagar, Panipath, house no. 89')
                      ],
                    ),
                    TextButton(
                        onPressed: () async {
                          return showModalBottomSheet(
                              context: context,
                              builder: (BuildContext modalcontext) {
                                return EditDeliveryAddress(modalcontext);
                              });
                        },
                        child: Text('CHANGE',
                            style: TextStyle(
                                color: Color.fromRGBO(226, 51, 72, 1))))
                  ]),
            ),
          ),
        ),
      );
    }

    Widget CustomCircle(Function() press, bool isclicked, dynamic size) {
      return GestureDetector(
        onTap: press,
        child: Container(
            margin: EdgeInsets.only(right: 15),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.1,
            decoration: BoxDecoration(
              border: isclicked
                  ? Border.all(
                      color: Color.fromARGB(255, 92, 216, 232), width: 3)
                  : Border.all(color: Colors.grey.shade300, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Center(child: Text(size.toString()))),
      );
    }

    Widget CustomDropDown(BuildContext context, String attribute,
        CartProductModel product, int index) {
      return Container(
        child: Row(children: [
          Text.rich(TextSpan(text: attribute, children: [
            TextSpan(
                text: attribute.contains('Size')
                    ? product.size.contains('months')
                        ? product.size.replaceAll('onths', '').toString()
                        : product.size.replaceAll('ears', '').toString()
                    : product.quantity.toString())
          ])),
          IconButton(
              onPressed: () async {
                return showModalBottomSheet(
                    context: context,
                    builder: (BuildContext modalcontext) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: BlocProvider(
                          create: (context) =>
                              SelectattributeCubit(product, attribute),
                          child: BlocBuilder<SelectattributeCubit,
                              SelectattributeState>(
                            builder: (context, state) {
                              if (state is SelectattributeInitial) {
                                return Wrap(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              attribute.contains('Size')
                                                  ? 'Select Size'
                                                  : 'Select Quantity',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pop(modalcontext);
                                              },
                                              icon: Icon(Icons.close))
                                        ]),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: attribute.contains('Size')
                                            ? product.sizes.length
                                            : 10,
                                        itemBuilder: (BuildContext context,
                                            int l_index) {
                                          selected_attribute = state.index;
                                          return CustomCircle(
                                              () => BlocProvider.of<
                                                          SelectattributeCubit>(
                                                      context)
                                                  .OnClick(l_index, attribute),
                                              state.index == l_index
                                                  ? true
                                                  : false,
                                              attribute.contains('Size')
                                                  ? product.sizes[l_index]
                                                  : l_index + 1);
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (selected_attribute == null) {
                                            attribute.contains('Size')
                                                ? selected_attribute =
                                                    product.size
                                                : selected_attribute =
                                                    product.quantity;
                                          } else {
                                            attribute.contains('Size')
                                                ? selected_attribute = product
                                                    .sizes[selected_attribute]
                                                : selected_attribute =
                                                    selected_attribute + 1;
                                          }
                                          BlocProvider.of<SelectattributeCubit>(
                                                  context)
                                              .UpdateCartAttribute(
                                                  index,
                                                  attribute,
                                                  selected_attribute);
                                          Navigator.pop(modalcontext);
                                        },
                                        child: Text('DONE'),
                                        style: ElevatedButton.styleFrom(
                                            primary:
                                                Color.fromRGBO(226, 51, 72, 1)),
                                      ),
                                    )
                                  ],
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                      );
                    });
              },
              icon: Icon(Icons.arrow_drop_down))
        ]),
      );
    }

    Widget CustomProductCard(
        CartProductModel product, Function() close, int index) {
      return Card(
        margin: EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/detail', arguments: {
                      'Name': product.name,
                      'Brand': product.brand,
                      'Sizes': product.sizes,
                      'Colors': product.colours,
                      'Images': product.img,
                      'Description': product.desc,
                      'Price': product.price
                    });
                  },
                  child: CachedNetworkImage(
                      imageUrl: product.img[0],
                      width: MediaQuery.of(context).size.width * 0.3)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.desc,
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    Text.rich(TextSpan(
                        text: 'Sold by: ',
                        children: [TextSpan(text: 'Rajo Store')])),
                    Row(children: [
                      product.sizes.isNotEmpty
                          ? CustomDropDown(context, 'Size:', product, index)
                          : Container(),
                      CustomDropDown(context, 'Quantity:', product, index)
                    ]),
                    Text('₹ ${product.price}',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('In stock', style: TextStyle(color: Colors.green)),
                    Text(product.name)
                  ],
                ),
              ),
              IconButton(onPressed: close, icon: Icon(Icons.close))
            ],
          ),
        ),
      );
    }

    Widget CustomPriceRow(String detail, String value, bool isbold) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(detail,
                style: TextStyle(fontWeight: isbold ? FontWeight.bold : null)),
            Text('₹ $value',
                style: TextStyle(fontWeight: isbold ? FontWeight.bold : null))
          ],
        ),
      );
    }

    Widget PriceDetails(List products) {
      double totalprice = 0;
      double discount = 200;
      double conveince_charge = 25;
      products.forEach(
        (element) => totalprice =
            double.parse(element['price']) * element['quantity'] + totalprice,
      );
      return Card(
        margin: EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              Text.rich(TextSpan(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  text: 'PRICE DETAILS ',
                  children: [TextSpan(text: '(${products.length} items)')])),
              Divider(
                  color: Colors.grey.shade200,
                  indent: 0,
                  endIndent: 0,
                  thickness: 2),
              Column(
                children: [
                  CustomPriceRow('Total MRP', totalprice.toString(), false),
                  CustomPriceRow('Discount on MRP', discount.toString(), false),
                  CustomPriceRow(
                      'Convenience Fee', conveince_charge.toString(), false),
                  Divider(
                      color: Colors.grey.shade200,
                      indent: 0,
                      endIndent: 0,
                      thickness: 2),
                  CustomPriceRow(
                      'Total Amount',
                      '${totalprice - discount + conveince_charge}'.toString(),
                      true)
                ],
              )
            ],
          ),
        ),
      );
    }

    Widget ContinueButton(List products) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.98,
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/checkout', arguments: products);
            },
            child: Text('CONTINUE'),
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(226, 51, 72, 1),
            )),
      );
    }

    return SingleChildScrollView(child: BlocBuilder<CartCubit, CartState>(
        builder: (BuildContext context, state) {
      if (state is CartHasData) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            DeliveryAddress(),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.products.length,
              itemBuilder: (BuildContext context, int index) {
                return CustomProductCard(
                    CartProductModel(
                        price: state.products[index]['price'],
                        name: state.products[index]['name'],
                        img: state.products[index]['img'],
                        desc: state.products[index]['desc'],
                        brand: state.products[index]['brand'],
                        sizes: state.products[index]['sizes'],
                        size: state.products[index]['size'],
                        colour: state.products[index]['colour'],
                        quantity: state.products[index]['quantity'],
                        colours: state.products[index]['colours']), (() {
                  BlocProvider.of<CartCubit>(context).RemoveProduct(index);
                }), index);
              },
            ),
            PriceDetails(state.products),
            ContinueButton(state.products)
          ],
        );
      } else if (state is CartEmpty) {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Image(image: AssetImage('assets/emptycart.png'), fit: BoxFit.cover),
            Text('Your Cart is Empty.',
                style: TextStyle(fontWeight: FontWeight.bold))
          ],
        ));
      } else {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            CircularProgressIndicator()
          ],
        ));
      }
    }));
  }
}
