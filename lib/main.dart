import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/components/numpad.dart';
import 'package:test_app/pages/home.dart';
import 'package:test_app/pages/login.dart';
import 'package:test_app/pages/register.dart';
import 'package:test_app/services/auth_cubit.dart';
import 'util/theme.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/numpad',
  theme: mainTheme(),
  routes: {
    '/': (context) => BlocProvider(
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
      child: Numpad(),
    ),
  },
));