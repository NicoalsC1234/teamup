import 'package:flutter/material.dart';
import 'package:teamup/screen/login_screen.dart';
import 'package:teamup/screen/charging_screen.dart';
import 'package:teamup/screen/register_screen.dart';
import 'package:teamup/screen/home_screen.dart';

class Routes {
  static const charging = '/';
  static const login = '/login';
  static const profile = '/profile';
  static const home = '/home';
  static const register = '/register';
  static const teams = '/teams';
  static const players = '/players';
  static const matchs = '/matchs';
  static const map = '/map';
  static const referee = '/referee';

  static Route routes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case login:
        return _buildRoute(LoginScreen.create);
      case charging:
        return _buildRoute(SplashScreen.create);
      case register:
        return _buildRoute(RegisterScreen.create);
      case home:
        return _buildRoute(HomeScreen.create);
      default:
        throw Exception('Route does not exist');
    }
  }

  static MaterialPageRoute _buildRoute(Function build) =>
      MaterialPageRoute(builder: (context) => build(context));
}
