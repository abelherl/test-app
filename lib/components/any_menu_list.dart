import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:test_app/const.dart';
import 'package:test_app/models/any_menu_item.dart';

class AnyMenuList extends StatefulWidget {
  @override
  _AnyMenuListState createState() => _AnyMenuListState();
}

class _AnyMenuListState extends State<AnyMenuList> {
  var amount = 0;
  var dummy = AnyMenuItem(
      name: 'Pizza SS',
      price: '500',
      description: 'Topped with cheese and stuffs. With extra long description.',
      category: 'food',
      imageUrl: 'https://www.simplyrecipes.com/wp-content/uploads/2019/09/easy-pepperoni-pizza-lead-4.jpg',
      soldOut: false);
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: aBackgroundColor,
      body: Center(
        child: Parent(
          gesture: Gestures()
            ..isTap((isTap) {
              if(!dummy.soldOut) {
                setState(() => pressed = isTap);
              }
            })
            ..onTap(() {
              if(!dummy.soldOut) {
                setState(() => amount += 1);
              }
            })
            ..onLongPress(() {
              setState(() => amount = 0);
            }),
          style: ParentStyle()
            ..scale(pressed ? 0.95 : 1)
            ..animate(300, Curves.easeOutQuart),
          child: Stack(
            children: [
              Parent(
                style: ParentStyle()
                  ..opacity(dummy.soldOut ? 0.5 : 1)
                  ..height(115)
                  ..width(double.infinity)
                  ..padding(all: aPadding)
                  ..margin(all: aPadding, bottom: 0)
                  ..background.color(Colors.white)
                  ..borderRadius(all: aBorderRadius)
                  ..elevation(pressed ? 0 : 20, color: aShadowColor)
                  ..animate(300, Curves.easeOutQuart)
                  ..ripple(dummy.soldOut ? false : true, splashColor: aLightRed, highlightColor: Colors.transparent,),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Parent(
                      style: ParentStyle()
                        ..height(80)
                        ..width(80)
                        ..borderRadius(all: aBorderRadius)
                        ..background.image(url: dummy.imageUrl, fit: BoxFit.cover),
                    ),
                    SizedBox(width: aPadding,),
                    Column(
                      children: [
                        Container(
                          width: 200,
                          child: Text(
                            dummy.name,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: aHeader4Style,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        SizedBox(height: aPadding - 10,),
                        Container(
                          width: 200,
                          child: Text(
                            dummy.description,
                            style: aBodyLightStyle,
                            maxLines: 3,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 29,
                right: 29,
                child: Text(
                  dummy.soldOut ? 'Sold Out!' : 'SAR ${dummy.price}',
                  style: dummy.soldOut ? aErrorStyle : aHeader4Style,
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
      ),
    );
  }
}
