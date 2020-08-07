import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:clay_containers/clay_containers.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isTapped = false;

  final cardStyle = ParentStyle()
    ..animate(300, Curves.decelerate)
    ..elevation(50)
    ..background.color(Colors.grey[200])
    ..padding(all: 15)
    ..width(double.infinity)
    ..maxHeight(70)
    ..borderRadius(all: 15)
    ..margin(all:15)
    ..ripple(true);

  final title = TxtStyle()
    ..fontSize(15)
    ..bold()
    ..textAlign.left();

  final subtitle = TxtStyle()
    ..fontSize(13)
    ..textColor(Colors.grey)
    ..textAlign.left();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Parent(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Txt('Click me', style: title,),
                Txt('So you can see the tap animation.', style: subtitle,
                ),
              ],
            ),
          ),
          gesture: Gestures()
            ..onTapDown((_) {
              setState(() {
                isTapped = true;
              });
            })
            ..onTapUp((_) {
              setState(() {
                isTapped = false;
              });
            })
            ..onTapCancel(() {
              setState(() {
                isTapped = false;
              });
            }),
          style: cardStyle.clone()
            ..elevation(isTapped ? 0 : 50)
            ..scale(isTapped ? 0.95 : 1),
        ),
      ),
    );
  }
}
