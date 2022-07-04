import 'package:flutter/material.dart';
import 'package:myapp/Screens/Auth/OTP/confirm_otp_page.dart';
import 'package:myapp/Screens/Auth/OTP/phone_number.dart';
import 'package:myapp/Screens/Auth/forgot_password_screen.dart';
import 'package:myapp/Screens/Auth/login_page.dart';
import 'package:myapp/Screens/Auth/register_page.dart';
import 'package:myapp/Screens/Intro/intro_page.dart';
import 'package:myapp/Screens/Main/main_page.dart';
import 'package:myapp/Screens/Splash/splash_page.dart';

class AutoRouter {
  Route? onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/forgotpass':
        return MaterialPageRoute(builder: (_) => ForgotPasswordPage());
      case '/phn':
        return MaterialPageRoute(builder: (_) => PhoneNumber());
      case '/otp':
        var phn = settings.arguments;
        return MaterialPageRoute(builder: (_) => ConfirmOtpPage(phn: phn));
      case '/main':
        return MaterialPageRoute(builder: (_) => MainPage());
      case '/intro':
        return MaterialPageRoute(builder: (_) => IntroPage());
      default:
        return MaterialPageRoute(builder: (_) => RegisterPage());
    }
  }
}
