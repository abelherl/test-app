import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:test_app/const.dart';

class DeviceConfiguration extends StatefulWidget {
  @override
  _DeviceConfigurationState createState() => _DeviceConfigurationState();
}

class _DeviceConfigurationState extends State<DeviceConfiguration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(aPadding),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(flex: 1),
                Text(
                  'Setup Your Device',
                  style: aHeader2Style,
                ),
                Spacer(flex: 1),
                Txt(
                    'Start Selling with AnyFood',
                    gesture: Gestures()
                      ..onTap(() => Navigator.pushNamed(context, '/pin')),
                    style: TxtStyle()
                      ..width(300)
                      ..padding(all: 15)
                      ..fontFamily(aFontFamily)
                      ..alignmentContent.center()
                      ..fontSize(14)
                      ..textColor(Colors.white)
                      ..bold()
                      ..textDecoration(TextDecoration.none)
                      ..borderRadius(all: aBorderRadius)
                      ..background.color(aRed)
                      ..ripple(true)
                ),
                Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
