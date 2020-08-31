import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/pages/login.dart';
import 'package:test_app/pages/register.dart';
import 'package:test_app/services/auth_cubit.dart';
import 'util/theme.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  theme: mainTheme(),
  routes: {
    '/': (context) => BlocProvider(
      create: (context) => AuthCubit(),
      child: Register(),
    ),
  },
));