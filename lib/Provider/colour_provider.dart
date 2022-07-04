import 'package:flutter/cupertino.dart';

class ColourProvider with ChangeNotifier {
  int colourindex = 0;

  void ChangeColour(int index) {
    colourindex = index;
    notifyListeners();
  }
}
