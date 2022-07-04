part of 'otpverification_cubit.dart';

@immutable
abstract class OtpverificationState {}

class OtpverificationInitial extends OtpverificationState {}

class OtpverificationFailed extends OtpverificationState {
  OtpverificationFailed(this.msg);
  final String msg;
}

class OtpverificationGenerated extends OtpverificationState {
  OtpverificationGenerated(
      {required this.verificationcode, required this.resendtoken});
  final String verificationcode;
  final int? resendtoken;
}

class OtpverificationTimeOut extends OtpverificationState {
  OtpverificationTimeOut(this.verificatiionId);
  final String verificatiionId;
}

class OtpverificationComplete extends OtpverificationState {}

class OtpverificationOngoing extends OtpverificationState {}
