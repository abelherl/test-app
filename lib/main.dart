import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/components/any_numpad.dart';
import 'package:test_app/pages/device_configuration.dart';
import 'package:test_app/pages/onboarding.dart';
import 'package:test_app/pages/home.dart';
import 'package:test_app/pages/login.dart';
import 'package:test_app/pages/pin.dart';
import 'package:test_app/pages/register.dart';
import 'package:test_app/pages/splash.dart';
import 'package:test_app/pages/starting_cash.dart';
import 'package:test_app/services/auth_cubit.dart';
import 'util/theme.dart';

void main() => runApp(MaterialApp(
  theme: mainTheme(),
  routes: {
    '/register': (context) => BlocProvider(
      create: (context) => AuthCubit(),
      child: Register(),
    ),
    '/login': (context) => BlocProvider(
      create: (context) => AuthCubit(),
      child: Login(),
    ),
    '/home': (context) => BlocProvider(
      create: (context) => AuthCubit(),
      child: Home(),
    ),
    '/numpad': (context) => BlocProvider(
      create: (context) => AuthCubit(),
      child: AnyNumpad(),
    ),
    '/pin': (context) => BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(body: Pin()),
    ),
    '/starting_cash': (context) => StartingCash(),
    '/onboarding': (context) => Onboarding(),
    '/device_configuration': (context) => DeviceConfiguration(),
    '/': (context) => BlocProvider(
      create: (context) => AuthCubit(),
      child: Splash(),
    ),
  },
));