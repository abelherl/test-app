import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:test_app/const.dart';
import 'package:test_app/models/any_menu_item.dart';

class AnyMenuGrid extends StatefulWidget {
  AnyMenuGrid({
    @required this.item,
  });

  final AnyMenuItem item;

  @override
  _AnyMenuGridState createState() => _AnyMenuGridState(item);
}

class _AnyMenuGridState extends State<AnyMenuGrid> {
  _AnyMenuGridState(this.item);

  final AnyMenuItem item;
  var amount = 0;
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Stack(
          children: [
            Parent(
              gesture: Gestures()
                ..isTap((isTap) {
                  if(!item.soldOut) {
                    setState(() => pressed = isTap);
                  }
                })
                ..onTap(() {
                  if(!item.soldOut) {
                    setState(() => amount += 1);
                  }
                })
                ..onLongPress(() {
                  setState(() => amount = 0);
                }),
              style: ParentStyle()
                ..opacity(item.soldOut ? 0.5 : 1)
                ..width(double.infinity)
                ..padding(all: aPadding)
                ..margin(top: aPadding)
                ..background.color(Colors.white)
                ..borderRadius(all: aBorderRadius)
                ..scale(pressed ? 0.95 : 1)
                ..elevation(pressed ? 0 : 15, color: aShadowColor)
                ..animate(300, Curves.easeOutQuart)
                ..ripple(item.soldOut ? false : true, splashColor: aLightRed, highlightColor: Colors.transparent,),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Parent(
                    style: ParentStyle()
                      ..height(80)
                      ..width(80)
                      ..borderRadius(all: aBorderRadius)
                      ..background.image(url: item.imageUrl, fit: BoxFit.cover),
                  ),
                  SizedBox(height: aPadding,),
                  Container(
                    height: 30,
                    child: Center(
                      child: Text(
                        item.name,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: aHeader4Style,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                  SizedBox(height: aPadding - 10,),
                  Text(
                    item.soldOut ? 'Sold Out!' : 'SAR ${item.price}',
                    style: item.soldOut ? aErrorStyle : aBodyLightStyle,
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
    );
  }
}
