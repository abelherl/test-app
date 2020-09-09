import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:test_app/const.dart';
import 'package:test_app/models/any_menu_item.dart';

class AnyMenuGrid extends StatefulWidget {
  @override
  _AnyMenuGridState createState() => _AnyMenuGridState();
}

class _AnyMenuGridState extends State<AnyMenuGrid> {
  var amount = 0;
  var dummy = AnyMenuItem(
      name: 'Pizza SS',
      price: '500',
      category: 'food',
      imageUrl: 'https://www.simplyrecipes.com/wp-content/uploads/2019/09/easy-pepperoni-pizza-lead-4.jpg',
      soldOut: false);
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: aBackgroundColor,
      body: Center(
        child: Stack(
          children: [
            Parent(
              gesture: Gestures()
                ..isTap((isTap) {
                  if(!dummy.soldOut) {
                    setState(() => pressed = isTap);
                  }
                })
                ..onTap(() {
                  amount += 1;
                })
                ..onLongPress(() {
                  amount = 0;
                }),
              style: ParentStyle()
                ..opacity(dummy.soldOut ? 0.5 : 1)
                ..width(110)
                ..padding(all: aPadding)
                ..margin(all: aPadding)
                ..background.color(Colors.white)
                ..borderRadius(all: aBorderRadius)
                ..scale(pressed ? 0.95 : 1)
                ..elevation(pressed ? 0 : 20, color: aShadowColor)
                ..animate(300, Curves.easeOutQuart)
                ..ripple(dummy.soldOut ? false : true, splashColor: aLightRed, highlightColor: Colors.transparent,),
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
                    dummy.soldOut ? 'Sold Out!' : 'SAR ${dummy.price}',
                    style: dummy.soldOut ? aErrorStyle : aBodyLightStyle,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 5,
              left: 5,
              child: Txt(
                '$amount',
                style: TxtStyle()
                  ..width((amount == 0) ? 0 : 30)
                  ..height((amount == 0) ? 0 : 30)
                  ..alignmentContent.center()
                  ..textAlign.center()
                  ..fontSize(12)
                  ..textColor(Colors.white)
                  ..bold()
                  ..scale(pressed ? 0.95 : 1)
                  ..animate(300, Curves.easeOutQuart)
                  ..background.color(aRed)
                  ..borderRadius(all: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}