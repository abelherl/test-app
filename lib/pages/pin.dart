import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:test_app/const.dart';
import 'package:test_app/models/user.dart';
import 'package:test_app/models/user_model.dart';
import 'package:test_app/services/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

class Pin extends StatefulWidget {
  @override
  _PinState createState() => _PinState();
}

class _PinState extends State<Pin> {
  final inputs = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
  final runSpacing = 20.0;
  final listSize = 15;
  final columns = 3;
  final spacing = 20.0;
  final padding = 15.0;
  final fontSize = 300 / 20 + 300 / 20;
  final dummyPIN = '123321';

  bool isError = false;
  bool changePage = false;

  User dummy = User(0, 0, '', '');

  var pinBools = [false, false, false, false, false, false];
  var value = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = 270.0;
    final radius = maxWidth / 28;

    return Scaffold(
        backgroundColor: aBackgroundColor,
        body: SafeArea(
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              width: maxWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                  SizedBox(height: aLargerPadding),
                  Text(
                    'Enter Your Login PIN',
                    style: aTitleStyle,
                  ),
                  SizedBox(height: aPadding),
                  _buildPinIndicator(maxWidth, radius),
                  SizedBox(height: aPadding),
                  _buildErrorText(),
                  SizedBox(height: aPadding),
                  _buildNumpad(maxWidth, radius),
                ],
              ),
            ),
          ),
        ));
  }

  // inputNumber
  void inputNumber(String input) {
    var i = 0;
    var stop = false;

    if (value.length < 6) {
      // updating pinBools for the input indicator
      while (!stop) {
        if (!pinBools[i]) {
          setState(() {
            pinBools[i] = true;
            isError = false;
          });
          stop = true;
        }
        if (i == pinBools.length - 1) {
          stop = true;
        }
        i++;
      }

      // stop adding number after 6 digits
      setState(() => value = value + input);
      print('value: $value');

      // onSubmit PIN after 6 digits are inputted
      if (value.length == 6) {
        Timer(Duration(milliseconds: 500), () => onSubmit());
      }
    }
  }

  void onSubmit() {
    var text = 'Invalid PIN';
    final valid = (value == dummy.pin);
    final isLoggedIn = (context.bloc<AuthCubit>().state).isLoggedIn;

    setState(() => isError = !valid);

    print(isLoggedIn);

    if (valid) {
      text = 'Valid PIN';
      context.bloc<AuthCubit>().login();
    }

    print('error: $isError $text');
    init();
  }

  // set PIN related data to its initial value
  void init() async {
    final isLoggedIn = (context.bloc<AuthCubit>().state).isLoggedIn;
    print(isLoggedIn);

    if (isLoggedIn) {
      Navigator.pushNamed(context, '/starting_cash');
    }

    setState(() {
      value = '';
      pinBools = [false, false, false, false, false, false];
    });

    Response response;
    Dio dio = Dio();
    response = await dio.get('https://my-json-server.typicode.com/abelherl/test-app/db');
    print(response.data.toString());

    dummy = UserList.fromJsonMap(response.data).user[0];
    print(dummy.pin);
  }

  Center _buildErrorText() {
    return Center(
      child: Text(
        'Your PIN is invalid.',
        style: TextStyle(
          color: isError ? aRed : Colors.transparent,
          fontFamily: aFontFamily,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Stack _buildPinIndicator(double maxWidth, double radius) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: maxWidth / 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: pinBools.map((_) {
              return Parent(
                style: ParentStyle()
                  ..width(maxWidth / 12)
                  ..height(maxWidth / 12)
                  ..borderRadius(all: radius / 2)
                  ..background.color(Colors.white)
                  ..border(
                    all: 5,
                    color: isError ? aRed : Colors.transparent,
                  )
                  ..animate(400, Curves.easeOutQuart),
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: maxWidth / 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: pinBools.map((boolean) {
              return Parent(
                style: ParentStyle()
                  ..width(maxWidth / 12)
                  ..height(maxWidth / 12)
                  ..scale(0.9)
                  ..borderRadius(all: radius / 2)
                  ..background.color(boolean ? aGreen : Colors.white)
                  ..elevation(3, color: boolean ? aGreen : aShadowColor)
                  ..animate(400, Curves.easeOutQuart),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Column _buildNumpad(double maxWidth, double radius) {
    final buttonStyle = (String input) => TxtStyle()
      ..background.color(Colors.white)
      ..textColor(aDarkTextColor)
      ..alignmentContent.center()
      ..borderRadius(all: radius)
      ..elevation(5, color: aShadowColor)
      ..bold(true)
      ..fontFamily(aFontFamily)
      ..fontSize(fontSize)
      ..ripple(
        true,
        splashColor: aGreen,
        highlightColor: Colors.transparent,
      );

    final numpadStyle = ParentStyle()..maxWidth(maxWidth);

    final zeroNumpadStyle = ParentStyle()..maxWidth(maxWidth / 3 + padding / 2);

    return Column(
      children: [
        Parent(
          style: numpadStyle,
          child: GridView(
            padding: EdgeInsets.all(padding),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
              crossAxisCount: 3,
            ),
            children: inputs.map((input) {
              return Txt(
                input,
                gesture: Gestures()
                  ..onTap(() => setState(() {
                        inputNumber(input);
                      })),
                style: buttonStyle(input),
              );
            }).toList(),
          ),
        ),
        Parent(
          style: zeroNumpadStyle,
          child: GridView(
              padding: EdgeInsets.fromLTRB(15, spacing - padding, 15, 15),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                crossAxisCount: 1,
              ),
              children: [
                Txt(
                  '0',
                  gesture: Gestures()
                    ..onTap(() => setState(() {
                          inputNumber('0');
                        })),
                  style: buttonStyle('0'),
                ),
              ]),
        ),
      ],
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      String text, bool valid) {
    return Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(text),
      backgroundColor: valid ? aGreen : aRed,
      action: SnackBarAction(
        label: 'DISMISS',
        textColor: Colors.white,
        onPressed: () => SnackBarClosedReason.dismiss,
      ),
    ));
  }
}
