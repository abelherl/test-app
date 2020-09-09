import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:test_app/const.dart';
import 'package:test_app/models/any_menu_item.dart';

class AnyMenuGrid extends StatefulWidget {
  @override
  _AnyMenuGridState createState() => _AnyMenuGridState();
}

class _AnyMenuGridState extends State<AnyMenuGrid> {
  var dummy = AnyMenuItem(
      name: 'Pizza SS',
      price: '500',
      imageUrl: 'https://www.simplyrecipes.com/wp-content/uploads/2019/09/easy-pepperoni-pizza-lead-4.jpg',
      soldOut: false);
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: aBackgroundColor,
      body: Parent(
        gesture: Gestures()
          ..isTap((isTap) => setState(() => pressed = isTap)),
        style: ParentStyle()
          ..width(110)
          ..padding(all: aPadding)
          ..alignment.center()
          ..background.color(Colors.white)
          ..borderRadius(all: aBorderRadius)
          ..scale(pressed ? 0.95 : 1)
          ..elevation(pressed ? 0 : 20, color: aShadowColor)
          ..animate(300, Curves.easeOutQuart)
          ..ripple(true, splashColor: aLightRed, highlightColor: Colors.transparent,),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Parent(
              style: ParentStyle()
                ..height(80)
                ..width(80)
                ..borderRadius(all: aBorderRadius)
                ..background.image(url: dummy.imageUrl, fit: BoxFit.cover),
            ),
            SizedBox(height: aPadding,),
            Container(
              height: 30,
              child: Center(
                child: Text(
                  dummy.name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: aHeader4Style,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
            SizedBox(height: aPadding - 10,),
            Text(
              'SAR ${dummy.price}',
              style: aBodyLightStyle,
            ),
          ],
        ),
      ),
    );
  }
}
