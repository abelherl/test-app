import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:test_app/const.dart';

class DeviceConfiguration extends StatefulWidget {
  @override
  _DeviceConfigurationState createState() => _DeviceConfigurationState();
}

class _DeviceConfigurationState extends State<DeviceConfiguration> {
  var deviceID = '';
  var dummyID = 'DUMMY430918';
  bool isFilled = false;
  bool isError = false;
  bool isRtl = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(aPadding),
            child: Container(
              width: aStandardWidth + 50,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(flex: 2),
                  Text(
                    'Setup Your Device',
                    style: aHeader2Style,
                  ),
                  SizedBox(height: aPadding * 2),
                  _buildDeviceTextField(),
                  SizedBox(height: aPadding * 2),
                  _buildDeviceButton(),
                  SizedBox(height: 10),
                  _buildNotRegisteredText(),
                  SizedBox(height: aPadding * 2),
                  Text(
                    'How to Get Device ID',
                    style: aHeader4Style,
                  ),
                  SizedBox(height: 10),
                  _buildTutorialRow(number: '1', description: ''),
                  SizedBox(height: 5),
                  _buildTutorialRow(
                    number: '2',
                    description: 'Go to Setting > Device > Add Device',
                  ),
                  SizedBox(height: 5),
                  _buildTutorialRow(
                    number: '3',
                    description: 'Create & Get Device ID',
                  ),
                  SizedBox(height: 5),
                  _buildTutorialRow(
                    number: '4',
                    description: 'Input Device ID on POS',
                  ),
                  Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSubmit() {
    final valid = (deviceID.toUpperCase() == dummyID);
    setState(() => isError = !valid);

    if (valid) {
      Navigator.pushReplacementNamed(context, '/pin');
    }
  }

  Container _buildTutorialRow({String number, String description}) {
    if (number == '1') {
      return Container(
        width: aStandardWidth + 50,
        child: Row(
          children: [
            Txt(
              '1',
              style: TxtStyle()
                ..width(20)
                ..height(20)
                ..alignmentContent.center()
                ..textAlign.center()
                ..fontSize(12)
                ..textColor(aLightTextColor)
                ..borderRadius(all: 15)
                ..border(
                  all: 1,
                  color: aLightTextColor,
                ),
            ),
            SizedBox(width: 10),
            Txt(
              'Login at ',
              style: TxtStyle()
                ..fontSize(12)
                ..textColor(aLightTextColor)
                ..fontFamily(aFontFamily),
            ),
            Txt(
              'https://app.anyfood.com',
              style: TxtStyle()
                ..fontSize(12)
                ..textColor(aRed)
                ..fontFamily(aFontFamily)
                ..textOverflow(TextOverflow.fade),
            ),
          ],
        ),
      );
    } else {
      return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Txt(
              number,
              style: TxtStyle()
                ..width(20)
                ..height(20)
                ..alignmentContent.center()
                ..textAlign.center()
                ..fontSize(12)
                ..textColor(aLightTextColor)
                ..borderRadius(all: 15)
                ..border(
                  all: 1,
                  color: aLightTextColor,
                ),
            ),
            SizedBox(width: 10),
            Txt(
              description,
              style: TxtStyle()
                ..fontSize(12)
                ..textColor(aLightTextColor)
                ..fontFamily(aFontFamily),
            ),
          ],
        ),
      );
    }
  }

  Row _buildNotRegisteredText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Not Registered Yet? ',
          style: aBodyLightStyle,
        ),
        Parent(
          gesture: Gestures()..onTap(() {}),
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: aRed,
              fontFamily: aFontFamily,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.none,
              fontSize: 14,
            ),
          ),
        )
      ],
    );
  }

  Txt _buildDeviceButton() {
    return Txt('Next',
        gesture: Gestures()..onTap(() => onSubmit()),
        style: TxtStyle()
          ..opacity(isFilled ? 1 : 0.5)
          ..width(aStandardWidth)
          ..padding(all: 10)
          ..fontFamily(aFontFamily)
          ..alignmentContent.center()
          ..fontSize(14)
          ..textColor(Colors.white)
          ..bold()
          ..textDecoration(TextDecoration.none)
          ..borderRadius(all: aBorderRadius)
          ..background.color(aRed)
          ..ripple(isFilled ? true : false));
  }

  Column _buildDeviceTextField() {
    return Column(
      children: [
        Container(
          width: aStandardWidth,
          child: Text(
            'Device ID',
            style: aTitleStyle,
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(height: 5),
        Parent(
          style: ParentStyle()
            ..animate(300, Curves.easeOutQuart)
            ..width(aStandardWidth)
            ..height(40)
            ..background.color(aBackgroundColor)
            ..borderRadius(all: aBorderRadius)
            ..border(all: aBorderWidth, color: isError ? aRed : aBorderColor),
          child: Txt(
            '',
            style: TxtStyle()
              ..height(double.infinity)
              ..width(double.infinity)
              ..alignmentContent.center()
              ..padding(left: 15)
              ..fontFamily(aFontFamily)
              ..textColor(aDarkTextColor)
              ..textAlign.start()
              ..bold()
              ..editable(
                  placeholder: 'Type your device ID here',
                  onChange: (newValue) {
                    setState(() {
                      if (newValue == '') {
                        isFilled = false;
                      } else {
                        isFilled = true;
                      }
                      isError = false;
                      deviceID = newValue;
                    });
                  }),
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: aStandardWidth,
          child: Text(
            'Please enter your valid device ID.',
            style: TextStyle(
              color: isError ? aRed : Colors.transparent,
              fontFamily: aFontFamily,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
