import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const customboxshadow = BoxShadow(
    color: Color.fromRGBO(222, 219, 219, 1), blurRadius: 14, spreadRadius: 8);

const textcolor = Color.fromRGBO(55, 53, 53, 1);

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kInvalidNumber = "Invalid Phone Number";

const String dummyProfile =
    'https://cdn-icons-png.flaticon.com/128/2922/2922510.png';
const String dummyProfilefailled =
    'https://cdn3.iconfinder.com/data/icons/toolbar-people/512/user_problem_man_male_person_profile-512.png';

final Widget wrong =
    Text('Something went wrong.', style: GoogleFonts.roboto(fontSize: 15));
final Widget loading = Center(child: CircularProgressIndicator());

final custom_divider = Divider(
    color: Colors.grey.shade200, indent: 5, endIndent: 5, thickness: 2);
