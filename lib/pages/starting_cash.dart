import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:test_app/components/any_button.dart';
import 'package:test_app/const.dart';

class StartingCash extends StatefulWidget {
  @override
  _StartingCashState createState() => _StartingCashState();
}

class _StartingCashState extends State<StartingCash> {
  String value = '';
  String time = '09:00 AM';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(aPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Current Shift',
                  style: aHeader3Style,
                ),
                SizedBox(height: 35),
                _buildStartingTextField(),
                SizedBox(height: aPadding * 2),
                _buildStartShiftButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Txt _buildStartShiftButton(BuildContext context) {
    return Txt(
      'Start Shift',
      style: TxtStyle()
        ..opacity(1)
        ..width(aStandardWidth)
        ..height(40)
        ..textColor(Colors.white)
        ..bold()
        ..alignmentContent.center()
        ..borderRadius(all: aBorderRadius)
        ..background.color(aRed)
        ..elevation(5, color: aRed)
        ..ripple(true),
    );
  }

  Column _buildStartingTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Starting Cash',
          style: aTitleStyle,
        ),
        SizedBox(height: 5),
        Parent(
          style: ParentStyle()
            ..width(aStandardWidth)
            ..height(40)
            ..background.color(aBackgroundColor)
            ..borderRadius(all: aBorderRadius)
            ..border(all: aBorderWidth, color: aBorderColor),
          child: Row(
            children: [
              Expanded(
                child: Txt(
                  '',
                  style: TxtStyle()
                    ..height(double.infinity)
                    ..alignmentContent.center()
                    ..padding(left: 15)
                    ..fontFamily(aFontFamily)
                    ..textColor(aDarkTextColor)
                    ..bold()
                    ..border(right: 1, color: aBorderColor)
                    ..editable(
                        placeholder: '0',
                        keyboardType: TextInputType.number,
                        onChange: (text) {
                          setState(() => value = text);
                        }),
                ),
              ),
              Txt(
                'SAR',
                style: TxtStyle()
                  ..width(60)
                  ..height(double.infinity)
                  ..borderRadius(
                      topRight: aBorderRadius, bottomRight: aBorderRadius)
                  ..alignmentContent.center()
                  ..fontFamily(aFontFamily)
                  ..textColor(aLightTextColor)
                  ..background.color(aInactiveColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
