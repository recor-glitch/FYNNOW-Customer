import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/constants.dart';

class PhoneNumber extends StatefulWidget {
  @override
  _PhoneNumberState createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  TextEditingController phoneNumber = TextEditingController();

  GlobalKey prefixKey = GlobalKey();
  double prefixWidth = 0;
  String? error;

  Widget prefix() {
    return Container(
        key: prefixKey,
        margin: EdgeInsets.only(right: 4.0),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.black, width: 0.5))),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text('+91 (IND)', style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.bold)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Widget title = Text('OTP Verification',
        style: GoogleFonts.roboto(fontSize: 30, fontWeight: FontWeight.bold));

    Widget subTitle = Padding(
        padding: const EdgeInsets.only(right: 56.0),
        child: Text(
          'Enter your registered mobile number to get the OTP',
          style: GoogleFonts.roboto(fontSize: 15),
        ));

    Widget sendButton = InkWell(
      onTap: () {
        if (phoneNumber.text.isNotEmpty && phoneNumber.text.length == 10) {
          Navigator.pushNamed(context, '/otp', arguments: phoneNumber.text);
        } else {
          setState(() {
            error = kInvalidNumber;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color.fromRGBO(226, 51, 72, 1),
        ),
        child: Center(
            child: Text('Send OTP',
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold))),
      ),
    );

    Widget phoneForm = Container(
      height: 210,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              prefix(),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        error = null;
                      });
                    },
                    decoration: InputDecoration(errorText: error),
                    controller: phoneNumber,
                    style: TextStyle(fontSize: 16.0),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: sendButton,
          ),
        ],
      ),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/bg.png'), fit: BoxFit.cover)),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Spacer(flex: 2),
                  title,
                  Spacer(),
                  subTitle,
                  Spacer(flex: 1),
                  phoneForm,
                  Spacer(flex: 2)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
