import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'util/theme.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  theme: mainTheme(),
  routes: {
    '/': (context) => Home(),
  },
));