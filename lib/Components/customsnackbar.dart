import 'package:flutter/material.dart';

ScaffoldFeatureController CustomSnackbar(String data, BuildContext context, {Duration? time}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: time != null? time : Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade900),
          height: MediaQuery.of(context).size.height * 0.06,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(data)),
          ))));
}
