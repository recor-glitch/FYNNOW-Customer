import 'package:flutter/material.dart';
import 'package:myapp/Components/customAppBar.dart';
import 'package:myapp/Screens/Cart/components/body.dart';

class Cart extends StatelessWidget {
  Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
              child: CustomAppBar(ispress: false)),
          backgroundColor: Colors.grey.shade200,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Body(),
          ),
        ),
      ),
    );
  }
}
