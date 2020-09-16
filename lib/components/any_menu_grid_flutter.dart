import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_app/const.dart';
import 'package:test_app/models/any_menu_item.dart';

class AnyMenuGridFlutter extends StatefulWidget {
  AnyMenuGridFlutter({
    @required this.item,
  });

  final AnyMenuItem item;

  @override
  _AnyMenuGridFlutterState createState() => _AnyMenuGridFlutterState(item);
}

class _AnyMenuGridFlutterState extends State<AnyMenuGridFlutter> {
  _AnyMenuGridFlutterState(this.item);

  final AnyMenuItem item;
  int amount = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shadowColor: aShadowColor,
      borderRadius: BorderRadius.circular(aBorderRadius),
      color: Colors.white,
      child: MaterialButton(
        onPressed: () {
          if (!item.soldOut) {
            setState(() => amount += 1);
          }
        },
        onLongPress: () {
          setState(() => amount = 0);
        },
        splashColor: aLightRed,
        highlightColor: Colors.transparent,
        padding: EdgeInsets.all(aPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(item.imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(aBorderRadius),
                  ),
                ),
                Container(
                  height: (amount == 0) ? 0 : 25,
                  width: (amount == 0) ? 0 : 25,
                  transform: Matrix4.translationValues(-1, -1, 0),
                  decoration: BoxDecoration(
                    color: aRed,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(aBorderRadius),
                        topLeft: Radius.circular(aBorderRadius)),
                    border: Border.all(color: Colors.white),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$amount',
                    style: aButtonTextStyle,
                  ),
                ),
              ],
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
                ),
              ),
            ),
            SizedBox(height: 7),
            Text(
              item.soldOut ? 'Sold Out!' : 'SAR ${item.price}',
              style: item.soldOut ? aErrorStyle : aBodyLightStyle,
            ),
          ],
        ),
      ),
    );
  }
}
