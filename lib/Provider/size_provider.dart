import 'package:flutter/cupertino.dart';

class SizeProvider with ChangeNotifier {
  int sizeindex = 0;

  void ChangeSize(int index) {
    sizeindex = index;
    notifyListeners();
  }
}
