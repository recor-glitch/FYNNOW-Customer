import 'package:flutter/material.dart';
import 'package:myapp/Components/customAppBar.dart';
import 'package:myapp/Screens/Home/components/custom_product_card.dart';

class ProductListing extends StatelessWidget {
  const ProductListing({Key? key, required this.products}) : super(key: key);
  final List products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: CustomAppBar(ispress: true)),
      backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(children: [
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 15, crossAxisSpacing: 15, crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return CustomProductCard(
                    press: () => Navigator.pushNamed(context, '/detail',
                        arguments: products[index]),
                    product: products[index]);
              },
            )
          ]),
        ),
      ),
    );
  }
}
