import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:test_app/const.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
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
                Expanded(
                  flex: 7,
                  child: Parent(
                    style: ParentStyle()
                      ..width(600)
                      ..borderRadius(all: aBorderRadius * 2)
                      ..background.color(aRed),
                    child: Parent(
                      style: ParentStyle()
                        ..width(600)
                        ..padding(all: aPadding)
                        ..borderRadius(all: aBorderRadius * 2)
                        ..background.image(
                          url: 'https://images.pexels.com/photos/3907161/pexels-photo-3907161.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                          fit: BoxFit.cover,
                        ),
                    ),
                  ),
                ),
                SizedBox(height: aPadding * 2,),
                Text(
                  'Selling Made Easy',
                  style: aHeader2Style,
                ),
                SizedBox(height: aPadding,),
                Text(
                  'Grow your business effortlessly with the POS for simplicity',
                  style: aHeader5Style,
                  textAlign: TextAlign.center,
                ),
                Spacer(flex: 1),
                Txt(
                    'Start Selling with AnyFood',
                    gesture: Gestures()
                      ..onTap(() => Navigator.pushReplacementNamed(context, '/device_configuration')),
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
