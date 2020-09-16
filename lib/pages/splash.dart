import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:test_app/services/auth_cubit.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();

    final isLoggedIn = context.bloc<AuthCubit>().state.isLoggedIn;
    String route = '/onboarding';

    print('Logged in: $isLoggedIn');

    if (isLoggedIn) {
      print('isLoggedIn called');
      route = '/home';
    }

    Timer(Duration(milliseconds: 1500), () => Navigator.pushReplacementNamed(context, route));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          image: AssetImage('assets/images/logo.png'),
        ),
      ),
    );
  }
}


