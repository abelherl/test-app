import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_app/const.dart';
import 'package:test_app/models/user.dart';
import 'package:test_app/models/user_model.dart';
import 'package:test_app/services/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:test_app/services/useful_methods.dart';

class Pin extends StatefulWidget {
  @override
  _PinState createState() => _PinState();
}

class _PinState extends State<Pin> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final inputs = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
  final columns = 3;
  final dummyPIN = '123321';

  String errorText = 'Your PIN is invalid';
  bool isError = false;
  bool changePage = false;

  User dummy = User(0, 0, '', '');

  List<bool> pinBools = [false, false, false, false, false, false];
  String value = '';

  @override
  void initState() {
    super.initState();
    init();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = 230.0;
    final radius = aBorderRadius;

    return Scaffold(
        key: _scaffoldKey,
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
                  SvgPicture.asset('assets/images/logo.svg', width: 160,),
                  SizedBox(height: aPadding),
                  Text(
                    isError ? errorText : 'Enter Your Login PIN',
                    style: isError ? aErrorStyle : aTitleStyle,
                  ),
                  SizedBox(height: aPadding),
                  _buildPinIndicator(maxWidth, radius),
                  SizedBox(height: aLargerPadding),
                  _buildNumpad(maxWidth, radius),
                ],
              ),
            ),
          ),
        ));
  }

  // inputNumber
  void inputNumber(String input) {
    int i = 0;
    bool stop = false;

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

  void onSubmit() {
    String text = 'Invalid PIN';
    final valid = (value == dummy.pin);
    final isLoggedIn = (context.bloc<AuthCubit>().state).isLoggedIn;

    setState(() => isError = !valid);

    print(isLoggedIn);

    if (valid) {
      text = 'Valid PIN';
      context.bloc<AuthCubit>().login();
    }

    print('error: $isError $text');
    _checkNetwork();
    init();
  }

  void _checkNetwork() async {
    bool connected = await checkNetwork();

    if (!connected) {
      bool reload = await showNoNetworkDialog(context, 'You seemed to be offline.\nPlease check your internet connection.');
      if (reload) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_,__,___) => BlocProvider(
              create: (context) => AuthCubit(),
              child: Scaffold(body: Pin()),
            ),
          )
        );
      }
    }
  }

  void getUsers() async {
    _checkNetwork();

    Response response;
    Dio dio = Dio();
    response = await dio.get('https://my-json-server.typicode.com/abelherl/test-app/db');
    print(response.data.toString());

    setState(() => dummy = UserList.fromJsonMap(response.data).user[0]);
    print(dummy.pin);
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
                  ..maxWidth(maxWidth / 12)
                  ..maxHeight(maxWidth / 12)
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
                  ..elevation(3, color: boolean ? aGreen : aLightTextColor)
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
      ..borderRadius(all: 8)
      ..elevation(5, color: aLightTextColor, opacity: 0.5)
      ..bold(true)
      ..fontFamily(aFontFamily)
      ..fontSize(25)
      ..ripple(
        true,
        splashColor: aGreen,
        highlightColor: Colors.transparent,
      );

    final numpadStyle = ParentStyle()..maxWidth(maxWidth);

    final zeroNumpadStyle = ParentStyle()
      ..maxWidth(maxWidth / 3 + aPadding / 2);

    return Column(
      children: [
        Parent(
          style: numpadStyle,
          child: GridView(
            padding: EdgeInsets.all(aPadding),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: aPadding,
              mainAxisSpacing: aPadding,
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
              padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: aPadding,
                mainAxisSpacing: aPadding,
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
}
