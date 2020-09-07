import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:test_app/const.dart';

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

  var pinBools = [false, false, false, false, false, false];
  var value = '';

  // inputNumber
  void inputNumber(String input) {
    var i = 0;
    var stop = false;

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
    if (value.length < 6) {
      setState(() => value = value + input);
      print('value: $value');
    }

    // onSubmit PIN after 6 digits are inputted
    if (value.length == 6) {
      // Timer(Duration(milliseconds: 1000), () => init());
      onSubmit();
    }
  }

  void onSubmit() {
    bool valid = (value == dummyPIN);
    setState(() => isError = !valid);
    print(isError);
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(valid ? 'Valid PIN' : 'Invalid PIN'),
      backgroundColor: valid ? aGreen : aRed,
      action: SnackBarAction(
        label: 'DISMISS',
        textColor: Colors.white,
        onPressed: () => SnackBarClosedReason.dismiss,
      ),
    ));
    init();
  }

  // set PIN related data to its initial value
  void init() {
    setState(() {
      value = '';
      pinBools = [false, false, false, false, false, false];
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxWidth = size.height / 2.3;
    final radius = maxWidth / 28;

    return Scaffold(
      backgroundColor: aBgColor,
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            width: maxWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/logo.png'),
                ),
                Expanded(child: SizedBox(height: 0,)),
                Text(
                  'Enter Your Login PIN',
                  style: TextStyle(
                    color: aDarkTextColor,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 15,),
                Stack(
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
                              ..border(all: 5, color: isError ? aRed : Colors.transparent,)
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
                              ..elevation(3, color: boolean ? aGreen : aShadowColor),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Expanded(child: SizedBox(height: 0,)),
                buildNumpad(maxWidth, radius),
              ],
            ),
          ),
        ),
      )
    );
  }

  Column buildNumpad(double maxWidth, double radius) {
    final buttonStyle = (String input) => TxtStyle()
      ..background.color(Colors.white)
      ..textColor(aDarkTextColor)
      ..alignmentContent.center()
      ..borderRadius(all: radius)
      ..elevation(5, color: aShadowColor)
      ..bold(true)
      ..fontFamily('Poppins')
      ..fontSize(fontSize)
      ..ripple(true, splashColor: aGreen, highlightColor: aGreen,);

    final numpadStyle = ParentStyle()
      ..maxWidth(maxWidth);

    final zeroNumpadStyle = ParentStyle()
      ..maxWidth(maxWidth / 3 + padding / 2);

    return Column(
              children: [
                Parent(
                  style: numpadStyle,
                  child: GridView(
                    padding: EdgeInsets.all(padding),
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
                    ]
                  ),
                ),
              ],
            );
  }
}