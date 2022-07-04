import 'package:flutter/material.dart';
import 'package:myapp/Components/custom_icons.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final TabController controller;
  const CustomBottomNavigationBar({Key? key, required this.controller})
      : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: TabBar(
            labelColor: Color.fromRGBO(225, 49, 73, 1),
            unselectedLabelColor: Color.fromRGBO(110, 110, 110, 1),
            controller: widget.controller,
            tabs: [
              Tab(icon: Icon(Custom_icons.home_colored)),
              Tab(icon: Icon(Custom_icons.category_colored)),
              Tab(icon: Icon(Custom_icons.cart_colored)),
              Tab(icon: Icon(Icons.person, size: 30))
            ]),
        color: Colors.white);
  }
}
