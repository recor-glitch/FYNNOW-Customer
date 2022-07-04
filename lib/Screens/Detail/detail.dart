import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Components/customAppBar.dart';
import 'package:myapp/Models/productmodel.dart';
import 'package:myapp/Screens/Detail/components/body.dart';

class DetailPage extends StatelessWidget {
  final Map product;
  const DetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: CustomAppBar(ispress: true)),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Body(
              product: ProductModel(
                  brand: product['Brand'],
                  name: product['Name'],
                  colours: product['Colors'],
                  desc: product['Description'],
                  img: product['Images'],
                  price: product['Price'],
                  sizes: product['Sizes']))),
    );
  }
}
