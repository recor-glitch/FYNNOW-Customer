import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/Infrastructure/userfcade.dart';

part 'otpverification_state.dart';

class OtpverificationCubit extends Cubit<OtpverificationState> {
  OtpverificationCubit() : super(OtpverificationInitial());
  String? phno, verficationid;

  Future<void> verifyOtp(String phn, String verificationcode, int? resendtoken) async {
    phno = phn;
    emit(OtpverificationOngoing());
    UserFcade fcade = UserFcade();
    await FirebaseAuth.instance.verifyPhoneNumber(
        forceResendingToken: resendtoken,
        phoneNumber: '+91 $phn',
        verificationCompleted: (PhoneAuthCredential credential) async {
          fcade.LinkWithCredential(credential).then((value) {
            if (value == 'success') {
              fcade.StoreUserdata(phn).then((storevalue) {
                if (storevalue == 'success') {
                  emit(OtpverificationComplete());
                } else {
                  emit(OtpverificationFailed(storevalue.replaceAll('-', ' ')));
                }
              });
            } else {
              emit(OtpverificationFailed(value.replaceAll('-', ' ')));
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          emit(OtpverificationFailed(e.code.replaceAll('-', ' ')));
        },
        codeSent: (String verificationId, int? resendToken) {
          emit(OtpverificationGenerated(
              verificationcode: verificationId, resendtoken: resendToken));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          emit(OtpverificationTimeOut(verificationId));
        },
        timeout: const Duration(seconds: 120));
  }
}
