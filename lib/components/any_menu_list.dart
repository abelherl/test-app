import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:test_app/const.dart';
import 'package:test_app/models/any_menu_item.dart';

class AnyMenuList extends StatefulWidget {
  AnyMenuList({
    @required this.item,
  });

  final AnyMenuItem item;
  @override
  _AnyMenuListState createState() => _AnyMenuListState(item);
}

class _AnyMenuListState extends State<AnyMenuList> {
  _AnyMenuListState(this.item);

  final AnyMenuItem item;
  int amount = 0;
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..scale(pressed ? 0.95 : 1)
        ..animate(300, Curves.easeOutQuart),
      child: Parent(
        gesture: Gestures()
          ..isTap((isTap) {
            if (!item.soldOut) {
              setState(() => pressed = isTap);
            }
          })
          ..onTap(() {
            if (!item.soldOut) {
              setState(() => amount += 1);
            }
          })
          ..onLongPress(() {
            setState(() => amount = 0);
          }),
        style: ParentStyle()
          ..opacity(item.soldOut ? 0.5 : 1)
          ..padding(all: aPadding)
          ..margin(bottom: aPadding)
          ..background.color(Colors.white)
          ..borderRadius(all: aBorderRadius)
          ..elevation(pressed ? 0 : 20, color: aShadowColor)
          ..animate(300, Curves.easeOutQuart)
          ..ripple(
            item.soldOut ? false : true,
            splashColor: aLightRed,
            highlightColor: Colors.transparent,
          ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Parent(
              style: ParentStyle()
                ..height(60)
                ..width(60)
                ..borderRadius(all: aBorderRadius)
                ..alignmentContent.topLeft()
                ..background.image(url: item.imageUrl, fit: BoxFit.cover),
              child: Container(
                transform: Matrix4.translationValues(-1, -1, 0),
                child: Txt(
                  '$amount',
                  style: TxtStyle()
                    ..opacity((amount == 0) ? 0 : 1)
                    ..width(25)
                    ..height(25)
                    ..alignmentContent.center()
                    ..textAlign.center()
                    ..fontSize(12)
                    ..textColor(Colors.white)
                    ..bold()
                    ..scale(pressed ? 0.95 : 1)
                    ..animate(400, Curves.easeOutQuart)
                    ..background.color(aRed)
                    ..border(all: 1, color: Colors.white)
                    ..borderRadius(
                        bottomRight: aBorderRadius, topLeft: aBorderRadius),
                ),
              ),
            ),
            SizedBox(
              width: aPadding,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    child: Text(
                      item.name,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: aHeader4Style,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  SizedBox(
                    height: aPadding - 10,
                  ),
                  Text(
                    item.description,
                    style: aBodyLightStyle,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                  ),
                ],
              ),
            ),
            SizedBox(width: 5,),
            Text(
              item.soldOut ? 'Sold Out!' : 'SAR ${item.price}',
              style: item.soldOut ? aErrorStyle : aHeader4Style,
            ),
          ],
        ),
      ),
    );
  }
}
