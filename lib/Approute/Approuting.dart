import 'package:flutter/material.dart';
import 'package:videalpha/splash/Splash.dart';
import 'package:videalpha/view/Loginpage.dart';
import 'package:videalpha/view/ManageProfile.dart';
import 'package:videalpha/view/Otppage.dart';
import 'package:videalpha/view/UserProfile.dart';

Route<dynamic> ApppRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Nameroute.slpash:
      return MaterialPageRoute(
          builder: (_) => const SplashScreen(), settings: routeSettings);
    case Nameroute.login:
      return MaterialPageRoute(
          builder: (_) => const Loginpage(), settings: routeSettings);
    case Nameroute.userProfile:
      return MaterialPageRoute(
          builder: (_) => const UserProfile(), settings: routeSettings);
    case Nameroute.otp:
      return MaterialPageRoute(
          builder: (_) => const OtpPage(), settings: routeSettings);
    case Nameroute.manageprofile:
      return MaterialPageRoute(
          builder: (_) => const ManageProfile(), settings: routeSettings);

    default:
      return MaterialPageRoute(
          builder: (_) => _UndefinedView(
                name: routeSettings.name,
              ),
          settings: routeSettings);
  }
}

class _UndefinedView extends StatelessWidget {
  const _UndefinedView({Key? key, this.name}) : super(key: key);
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Something went wrong for $name'),
      ),
    );
  }
}

class Nameroute {
  Nameroute._();
  static const String slpash = "/";
  static const String login = "/login";
  static const String otp = "/otp";
  static const String userProfile = "/userProfile";
  static const String manageprofile = "mngProfile";
}
