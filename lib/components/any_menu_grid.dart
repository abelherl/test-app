import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:test_app/const.dart';
import 'package:test_app/models/any_menu_item.dart';
import 'package:test_app/services/data_dummy.dart';

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
  void initState() {
    super.initState();

    dummyBilling.forEach((element) {
      print(element.menuId + item.id);
      if (element.menuId == item.id) {
        setState(() => amount = element.amount);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
//      gesture: Gestures()
//        ..isTap((isTap) {
//          if(!item.soldOut) {
//            setState(() => pressed = isTap);
//          }
//        })
//        ..onTap(() {
//          if(!item.soldOut) {
//            setState(() => amount += 1);
//          }
//        })
//        ..onLongPress(() {
//          setState(() => amount = 0);
//        }),
      style: ParentStyle()
        ..opacity(item.soldOut ? 0.5 : 1)
        ..width(double.infinity)
        ..padding(all: aPadding)
        ..background.color(Colors.white)
        ..borderRadius(all: aBorderRadius)
        ..scale(pressed ? 0.95 : 1)
        ..elevation(pressed ? 0 : 15, color: aShadowColor)
        ..animate(400, Curves.easeOutQuart)
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
                  ..animate(400, Curves.easeOutQuart)
                  ..background.color(aRed)
                  ..border(all: 1, color: Colors.white)
                  ..borderRadius(bottomRight: aBorderRadius, topLeft: aBorderRadius
                ),
              ),
            ),
          ),
          SizedBox(height: aPadding),
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
          SizedBox(height: aPadding - 10),
          Text(
            item.soldOut ? 'Sold Out!' : 'SAR ${item.price}',
            style: item.soldOut ? aErrorStyle : aBodyLightStyle,
          ),
        ],
      ),
    );
  }
}
