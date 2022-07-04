import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:myapp/constants.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image(
            image: AssetImage('assets/poster1.jpg'),
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high),
      ),
    );
  }
}
