import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/Bloc%20Provider/otp/otpverification_cubit.dart';
import 'package:myapp/Components/customsnackbar.dart';
import 'package:myapp/Infrastructure/userfcade.dart';
import 'package:pinput/pinput.dart';

class ConfirmOtpPage extends StatefulWidget {
  ConfirmOtpPage({required this.phn});
  final phn;
  @override
  _ConfirmOtpPageState createState() => _ConfirmOtpPageState();
}

class _ConfirmOtpPageState extends State<ConfirmOtpPage> {
  @override
  Widget build(BuildContext context) {
    Widget title = Text(
      'Confirm your OTP',
      style: GoogleFonts.roboto(fontSize: 30, fontWeight: FontWeight.bold),
    );

    Widget subTitle = Padding(
        padding: const EdgeInsets.only(right: 56.0),
        child: Text(
          'Please wait, we are confirming your OTP',
          style: GoogleFonts.roboto(fontSize: 15),
        ));

    Row buildTimer() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Resend again after ",
            style: GoogleFonts.roboto(),
          ),
          TweenAnimationBuilder(
            tween: Tween(begin: 120.0, end: 0.0),
            duration: Duration(seconds: 120),
            builder: (_, dynamic value, child) => Text(
              "00:${value.toInt()}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ],
      );
    }

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
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Spacer(flex: 2),
                  title,
                  Spacer(flex: 1),
                  subTitle,
                  Spacer(flex: 1),
                  OtpForm(phn: widget.phn),
                  Spacer(flex: 2),
                  Center(child: buildTimer()),
                  Spacer()
                ],
              ),
            ),
          ),
          Positioned(
            top: 35,
            left: 5,
            child: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}

class OtpForm extends StatefulWidget {
  const OtpForm({Key? key, required this.phn}) : super(key: key);
  final phn;

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  late String verificationcode;
  int? _resendtoken;
  UserFcade fcade = UserFcade();
  String? error;

  @override
  void initState() {
    verificationcode = '';
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<OtpverificationCubit>(context)
        .verifyOtp(widget.phn, verificationcode, null);
    super.didChangeDependencies();
  }

  AuthCredential GeneratePhnCredential() {
    return PhoneAuthProvider.credential(
        verificationId: verificationcode, smsCode: controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final cursor = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 21,
        height: 1,
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Color.fromRGBO(137, 146, 160, 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    final defaultPinTheme = PinTheme(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.05,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.blue),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Column(
      children: [
        Pinput(
          pinContentAlignment: Alignment.center,
          autofocus: true,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
          length: 6,
          errorText: error,
          onChanged: (value) {
            setState(() {
              error = null;
            });
          },
          controller: controller,
          focusNode: focusNode,
          separator: SizedBox(width: 16),
          showCursor: true,
          cursor: cursor,
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(right: 28.0),
          child: Center(
            child: BlocBuilder<OtpverificationCubit, OtpverificationState>(
              builder: (context, otpstate) {
                if (otpstate is OtpverificationOngoing) {
                  return Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromRGBO(226, 51, 72, 1),
                      ),
                      child: Center(child: CircularProgressIndicator()));
                }
                if (otpstate is OtpverificationComplete) {
                  Navigator.pushReplacementNamed(context, '/intro');
                }
                if (otpstate is OtpverificationFailed) {
                  return Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color.fromRGBO(226, 51, 72, 1),
                          ),
                          child: Center(
                            child: Text('Verify',
                                style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          )),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Text(otpstate.msg,
                          style: GoogleFonts.roboto(color: Colors.red))
                    ],
                  );
                }
                if (otpstate is OtpverificationGenerated) {
                  _resendtoken = otpstate.resendtoken;
                  verificationcode = otpstate.verificationcode;
                }
                if (otpstate is OtpverificationTimeOut) {
                  return Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color.fromRGBO(226, 51, 72, 1),
                          ),
                          child: Center(
                            child: Text('Verify',
                                style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          )),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      TextButton(
                          onPressed: () {
                            if (_resendtoken != null) {
                              BlocProvider.of<OtpverificationCubit>(context)
                                  .verifyOtp(widget.phn,
                                      otpstate.verificatiionId, _resendtoken);
                            }
                          },
                          child:
                              Text('Resend Otp', style: GoogleFonts.roboto()))
                    ],
                  );
                } else {
                  return InkWell(
                    onTap: () {
                      if (controller.text.length == 6 &&
                          verificationcode != '') {
                        AuthCredential credential = GeneratePhnCredential();
                        fcade.LinkWithCredential(credential).then((value) {
                          if (value == 'success') {
                            fcade.StoreUserdata(widget.phn).then((storevalue) {
                              if (storevalue == 'success') {
                                Navigator.pushReplacementNamed(
                                    context, '/intro');
                              } else {
                                CustomSnackbar(storevalue, context);
                              }
                            });
                          } else {
                            CustomSnackbar(value, context);
                          }
                        });
                      } else {
                        CustomSnackbar('Invalid Pin', context);
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
                          child: Text('Verify',
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
