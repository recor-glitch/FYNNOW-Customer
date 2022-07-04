import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/Components/customsnackbar.dart';
import 'package:myapp/Components/social_card.dart';
import 'package:myapp/Infrastructure/social_signup.dart';
import 'package:myapp/Infrastructure/userfcade.dart';
import 'package:myapp/constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    Widget title = Text(
      'Create Account',
      style: GoogleFonts.roboto(
          fontSize: 30, fontWeight: FontWeight.bold, color: textcolor),
    );

    Widget socialRegister = Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text('You can sign in with',
              style: GoogleFonts.roboto(fontSize: 12, color: textcolor)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SocialCard(
              icon: "assets/google.svg",
              press: () {
                GetGoogleCredential().then((value) {
                  if (value.isLeft) {
                    UserFcade google_facade = UserFcade();
                    google_facade.SigninWithCredential(value.left)
                        .then((credentialvalue) {
                      if (credentialvalue == 'success') {
                        Navigator.pushReplacementNamed(context, '/intro');
                      } else {
                        CustomSnackbar(credentialvalue, context);
                      }
                    });
                  } else {
                    CustomSnackbar(value.right, context);
                  }
                });
              },
            ),
            SocialCard(
              icon: "assets/facebook.svg",
              press: () {
                GetFacebookCredential().then((value) {
                  if (value.isLeft) {
                    UserFcade facebook_fcade = UserFcade();
                    facebook_fcade.SigninWithCredential(value.left)
                        .then((credentialvalue) {
                      if (credentialvalue == 'success') {
                        Navigator.pushReplacementNamed(context, '/intro');
                      } else {
                        CustomSnackbar(credentialvalue, context);
                      }
                    });
                  } else {
                    CustomSnackbar(value.right, context);
                  }
                });
              },
            ),
          ],
        )
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Spacer(flex: 3),
                  title,
                  Spacer(),
                  Spacer(flex: 1),
                  registerForm(),
                  Spacer(flex: 2),
                  Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: socialRegister),
                  Spacer(flex: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account? ',
                          style: GoogleFonts.roboto(color: textcolor)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text('Sign in',
                            style: GoogleFonts.roboto(
                                color: Colors.blue.shade600)),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class registerForm extends StatefulWidget {
  const registerForm({Key? key}) : super(key: key);

  @override
  State<registerForm> createState() => _registerFormState();
}

class _registerFormState extends State<registerForm> {
  final _formkey = GlobalKey<FormState>();

  bool errorvisible = false;
  String? email, pass, cmfpass;
  String? emailerror, passerror, cmfpasserror;
  bool isconfirmpassvisible = true;
  bool ispassvisible = true;
  UserFcade fcade = UserFcade();
  bool isclicked = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextFormField(
              onSaved: (newValue) => email = newValue,
              validator: (value) {
                if (value!.isEmpty) {
                  setState(() {
                    emailerror = kEmailNullError;
                  });
                } else if (!emailValidatorRegExp.hasMatch(value)) {
                  setState(() {
                    emailerror = kInvalidEmailError;
                  });
                }
              },
              onChanged: (value) {
                setState(() {
                  passerror = null;
                  emailerror = null;
                  cmfpasserror = null;
                });
              },
              style: TextStyle(fontSize: 16.0),
              decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "example@gmail.com",
                  errorText: emailerror,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Icon(Icons.email)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextFormField(
              onSaved: (newValue) => pass = newValue,
              validator: (value) {
                if (value!.isEmpty) {
                  setState(() {
                    passerror = kPassNullError;
                  });
                } else if (value.length < 6) {
                  setState(() {
                    passerror = kShortPassError;
                  });
                }
              },
              onChanged: (value) {
                setState(() {
                  passerror = null;
                  emailerror = null;
                  cmfpasserror = null;
                });
              },
              style: TextStyle(fontSize: 16.0),
              obscureText: ispassvisible,
              decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "********",
                  errorText: passerror,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: InkWell(
                      onTap: () {
                        if (ispassvisible) {
                          setState(() {
                            ispassvisible = false;
                          });
                        } else {
                          setState(() {
                            ispassvisible = true;
                          });
                        }
                      },
                      child: ispassvisible
                          ? Icon(Icons.lock)
                          : Icon(Icons.lock_open))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextFormField(
              onSaved: (newValue) => cmfpass = newValue,
              validator: (value) {
                if (value!.isEmpty) {
                  setState(() {
                    cmfpasserror = kPassNullError;
                  });
                }
              },
              onChanged: (value) {
                setState(() {
                  passerror = null;
                  emailerror = null;
                  cmfpasserror = null;
                });
              },
              style: TextStyle(fontSize: 16.0),
              obscureText: isconfirmpassvisible,
              decoration: InputDecoration(
                  labelText: "Comfirm Password",
                  hintText: "********",
                  errorText: cmfpasserror,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: InkWell(
                      onTap: () {
                        if (isconfirmpassvisible) {
                          setState(() {
                            isconfirmpassvisible = false;
                          });
                        } else {
                          setState(() {
                            isconfirmpassvisible = true;
                          });
                        }
                      },
                      child: isconfirmpassvisible
                          ? Icon(Icons.lock)
                          : Icon(Icons.lock_open))),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 20),
              child: GestureDetector(
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    setState(() {
                      isclicked = true;
                    });
                    if (pass == cmfpass) {
                      fcade.CreateUserWithEmailandPass(email!, pass!)
                          .then((value) {
                        if (value == 'success') {
                          Navigator.pushReplacementNamed(context, '/phn');
                        } else {
                          if (value.contains('email')) {
                            setState(() {
                              emailerror = value;
                            });
                          } else if (value.contains('password')) {
                            setState(() {
                              passerror = value;
                            });
                          } else {
                            CustomSnackbar(value, context);
                          }
                          setState(() {
                            isclicked = false;
                          });
                        }
                      });
                    } else {
                      setState(() {
                        passerror = kMatchPassError;
                        cmfpasserror = kMatchPassError;
                        isclicked = false;
                      });
                    }
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
                    child: isclicked
                        ? CircularProgressIndicator()
                        : Text('Sign up',
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
