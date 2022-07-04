import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/Components/customsnackbar.dart';
import 'package:myapp/Infrastructure/userfcade.dart';
import 'package:myapp/constants.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formkey = GlobalKey<FormState>();

  GlobalKey prefixKey = GlobalKey();
  double prefixWidth = 0;
  String? error, email;

  @override
  Widget build(BuildContext context) {
    Widget title = Text(
      'Reset Password',
      style: GoogleFonts.roboto(fontSize: 30, fontWeight: FontWeight.bold)
    );

    Widget subTitle = Padding(
        padding: const EdgeInsets.only(right: 56.0),
        child: Text(
          "Enter your registered email address and we'll send you a link to reset your password",
          style: GoogleFonts.roboto()
        ));

    Widget sendButton = InkWell(
      onTap: () {
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();

          UserFcade fcade = UserFcade();
          fcade.ResetPassword(email!).then((value) {
            if (value == 'success') {
              Navigator.pop(context);
            } else {
              CustomSnackbar(value, context);
            }
          });
        } else {
          CustomSnackbar(error!, context);
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
            child: Text('Reset',
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold))),
      ),
    );

    Widget phoneForm = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Form(
          key: _formkey,
          child: TextFormField(
            onSaved: (newValue) => email = newValue,
            validator: (value) {
              if (value!.isEmpty) {
                error = kEmailNullError;
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                error = kInvalidEmailError;
              }
            },
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              error = null;
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              hintText: 'example@gmail.com',
            ),
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        sendButton,
      ],
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
                  Spacer(flex: 2),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
