import 'package:flutter/material.dart';

Future CustomAlert(BuildContext context, Function() press, String title, String content) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.maybePop(context);
                },
                child: Text('CANCEL')),
            ElevatedButton(onPressed: press, child: Text('OK'))
          ],
        );
      });
}
