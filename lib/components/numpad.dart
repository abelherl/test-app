import 'package:clay_containers/clay_containers.dart';
import 'package:division/division.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_app/const.dart';

class Numpad extends StatefulWidget {
  @override
  _NumpadState createState() => _NumpadState();
}

class _NumpadState extends State<Numpad> {
  final inputs = ['1', '2', '3', '0', '4', '5', '6', '00', '7', '8', '9', '+'];
  final extras = ['C', 'Del'];
  final formatter = NumberFormat("#,###");

  String initialValue = 'SAR 0';
  String value = 'SAR 0';
  double width = 350;
//  double radius = 280 / 20;
  double radius = 0;
  double fontSize = 350 / 20 + 350 / 40;

  final double spacing = 3;

  void delete() {
    if (value.length == 5) {
      setState(() => value = initialValue);
    }
    if (!isInitialValue()) {
      setState(() => value = value.substring(0, value.length - 1));
    }
  }

  void inputNumber(String input) {
    if (!isInitialValue()) {
      setState(() => value = value + input);
    }
    else {
      if (!input.contains('0')) {
        setState(() => value = 'SAR $input');
      }
    }
  }

  String getPlaceholder() {
    return 'SAR ${formatter.format(double.parse(value.substring(4)))}';
  }

  bool isInitialValue() {
    bool isInitialValue = false;
    if (value == initialValue) {
      isInitialValue = true;
    }
    return isInitialValue;
  }

  bool isEnterButton(String str) {
    bool isEnterButton = false;
    if (str == '+') {
      setState(() {
        isEnterButton = true;
      });
    }
    print("$isEnterButton because $str");
    return isEnterButton;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Container(
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Txt(
                  getPlaceholder(),
                  style: TxtStyle()
                    ..height(70)
                    ..margin(bottom: spacing)
                    ..padding(horizontal: 25)
                    ..alignmentContent.centerRight()
                    ..background.color(Colors.white)
                    ..fontSize(35)
                    ..textColor(isInitialValue() ? Colors.blueGrey[300] : Colors.black87)
                    ..borderRadius(all: radius)
                    ..bold()
                    ..maxLines(1),
                ),
                Column(
                  children: [
                    GridView(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: spacing,
                        mainAxisSpacing: spacing,
                        childAspectRatio: 1.3,
                        crossAxisCount: 4,
                      ),
                      children: inputs.map((input) {
                        return Txt(
                          input,
                          gesture: Gestures()
                            ..onTap(() => setState(() {
                              if (isEnterButton(input)) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Custom input of: ${getPlaceholder()} added'),
                                    );
                                  },
                                );
                              }
                              else {
                                inputNumber(input);
                              }
                            })),
                          style: TxtStyle()
                            ..background.color(isEnterButton(input) ? Colors.red[900] : Colors.white)
                            ..textColor(isEnterButton(input) ? Colors.white : Colors.black87)
                            ..alignmentContent.center()
                            ..borderRadius(all: radius)
                            ..bold(isEnterButton(input) ? false : true)
                            ..fontSize(isEnterButton(input) ? fontSize + 10 : fontSize)
                        );
                      }).toList(),
                    ),
                    SizedBox(height: spacing,),
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Txt(
                              'C',
                              gesture: Gestures()
                                ..onTap(() => setState(() => value = initialValue)),
                              style: TxtStyle()
                                ..background.color(Colors.white)
                                ..padding(all: 15)
                                ..textColor(Colors.blueGrey[300])
                                ..alignmentContent.center()
                                ..bold()
                                ..borderRadius(all: radius)
                                ..fontSize(fontSize)
                          ),
                        ),
                        SizedBox(width: spacing,),
                        Expanded(
                          flex: 1,
                          child: Txt(
                              'Del',
                              gesture: Gestures()
                                ..onTap(() => setState(() => delete())),
                              style: TxtStyle()
                                ..background.color(Colors.white)
                                ..padding(all: 15)
                                ..textColor(Colors.blueGrey[300])
                                ..alignmentContent.center()
                                ..bold()
                                ..borderRadius(all: radius)
                                ..fontSize(fontSize)
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


//                      Flexible(
//                        flex: 1,
//                          child: Parent(
//                            gesture: Gestures()
//                              ..onTap(() => setState(() => value = removeLast(value))),
//                            style: ParentStyle()
//                              ..background.color(Colors.white)
//                              ..padding(all: radius)
//                              ..alignmentContent.center()
//                              ..borderRadius(all: radius)
//                              ..elevation(50),
//                            child: Icon(Icons.backspace, color: Colors.black87,),
//                        ),
//                      ),