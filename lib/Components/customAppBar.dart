import 'package:flutter/material.dart';
import 'package:myapp/Components/custom_icons.dart';
import 'package:myapp/Screens/Search/searchPage.dart';

class CustomAppBar extends StatelessWidget {
  final bool ispress;
  const CustomAppBar({Key? key, required this.ispress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ispress
                  ? GestureDetector(
                      onTap: () {
                        Navigator.maybePop(context);
                      },
                      child: Icon(Icons.arrow_back_ios_new,
                          color: Color.fromRGBO(110, 110, 110, 1)),
                    )
                  : Container(),
              Image(
                image: AssetImage('assets/logo.png'),
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.1,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchPage()));
                  },
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Custom_icons.search_icon,
                          size: 20, color: Color.fromRGBO(110, 110, 110, 1))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Custom_icons.heart_icon,
                        size: 20, color: Color.fromRGBO(110, 110, 110, 1))),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Custom_icons.bell_icon,
                        size: 20, color: Color.fromRGBO(110, 110, 110, 1))),
              )
            ],
          )
        ],
      ),
    );
  }
}
