import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:test_app/const.dart';
import 'package:test_app/services/auth_cubit.dart';
import 'package:test_app/services/useful_methods.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void check(String route) async {
    final bool connected = await checkNetwork();

    if (connected) {
      Timer(Duration(milliseconds: 1500),
              () => Navigator.pushReplacementNamed(context, route));
    } else {
      showInSnackBar(_scaffoldKey, "App currently running in offline mode");
      Timer(Duration(milliseconds: 3500),
              () => Navigator.pushReplacementNamed(context, route));
    }
  }

  @override
  void initState() {
    super.initState();

    String route = '/onboarding';
//    final isLoggedIn = context.bloc<AuthCubit>().state.isLoggedIn;
//    print('Logged in: $isLoggedIn');
//
//    if (isLoggedIn) {
//      print('isLoggedIn called');
//      route = '/home';
//    }
    check(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          image: AssetImage('assets/images/logo.png'),
        ),
      ),
    );
  }
}
