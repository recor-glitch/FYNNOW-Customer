import 'package:flutter/material.dart';
import 'package:myapp/Components/customAppBar.dart';
import 'package:myapp/Screens/Checkout/components/body.dart';

class CheckOut extends StatelessWidget {
  final List products;
  const CheckOut({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
            child: CustomAppBar(ispress: true)),
        body: Body(products: products),
      ),
    );
  }
}
