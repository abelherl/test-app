import 'package:flutter/material.dart';
import 'package:test_app/models/any_menu_item.dart';

import '../const.dart';

class AnyMenuListFlutter extends StatefulWidget {
  AnyMenuListFlutter({
    @required this.item,
  });

  final AnyMenuItem item;
  @override
  _AnyMenuListFlutterState createState() => _AnyMenuListFlutterState(item);
}

class _AnyMenuListFlutterState extends State<AnyMenuListFlutter> {
  _AnyMenuListFlutterState(this.item);

  final AnyMenuItem item;
  var amount = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: aPadding),
      child: Material(
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
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 60,
                    width: 60,
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
              SizedBox(width: aPadding),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: aHeader4Style,
                      overflow: TextOverflow.fade,
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
      ),
    );
  }
}
