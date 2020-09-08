import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:test_app/const.dart';

class AnyButton extends StatefulWidget {
  AnyButton({Key key, @required this.title, @required this.color, @required this.width, @required this.enabled}) : super(key: key);
  final String title;
  final Color color;
  final double width;
  final bool enabled;

  @override
  _AnyButtonState createState() => _AnyButtonState(title, color, width, enabled);
}

class _AnyButtonState extends State<AnyButton> {
  _AnyButtonState(this.title, this.color, this.width, this.enabled);
  final String title;
  final Color color;
  final double width;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Txt(
      title,
      gesture: Gestures()
        ..onTap(() {
        }),
      style: TxtStyle()
        ..opacity(1)
        ..width(350)
        ..height(40)
        ..textColor(Colors.white)
        ..alignmentContent.center()
        ..borderRadius(all: aBorderRadius)
        ..background.color(color)
        ..elevation(5, color: color)
        ..ripple(true),
    );
  }
}
