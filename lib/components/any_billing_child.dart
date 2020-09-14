import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:test_app/const.dart';
import 'package:test_app/models/any_billing_child_item.dart';

class AnyBillingChild extends StatefulWidget {
  AnyBillingChild({@required this.item, @required this.refresh});
  final AnyBillingChildItem item;
  final Function refresh;
  @override
  _AnyBillingChildState createState() => _AnyBillingChildState(item, refresh);
}

class _AnyBillingChildState extends State<AnyBillingChild> {
  _AnyBillingChildState(this.item, this.refresh);

  final Function refresh;
  var amount = 0;
  AnyBillingChildItem item;
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Parent(
        style: ParentStyle()
          ..height(100)
          ..padding(vertical: aPadding)
          ..background.color(Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: aHeader4Style,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
                SizedBox(
                  height: aPadding - 5,
                ),
                Text(
                  item.toppings,
                  style: aBodyLightStyle,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
                Text(
                  item.notes,
                  style: aBodyLightStyle,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'SAR ${item.price * item.amount}',
                  style: aHeader4Style,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
                SizedBox(
                  height: aPadding - 5,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildChangeAmountButton(Icons.remove, false),
                      SizedBox(width: aPadding - 5),
                      Container(
                        width: 20,
                        child: Text(
                          '${item.amount}',
                          style: aBodyStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: aPadding - 5),
                      _buildChangeAmountButton(Icons.add, true),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Parent _buildChangeAmountButton(IconData icon, bool addAmount) {
    return Parent(
      gesture: Gestures()..onTap(() => changeAmount(addAmount)),
      style: ParentStyle()
        ..height(25)
        ..width(25)
        ..background.color(aInactiveColor)
        ..borderRadius(all: 50)
        ..border(all: 1, color: aBorderColor)
        ..alignmentContent.center()
        ..ripple(true),
      child: Icon(icon, color: aRed, size: 20),
    );
  }

  void changeAmount(bool addAmount) {
    setState(() {
      if (!addAmount && item.amount == 1) {
        print('Removed from billing');
      }
      addAmount ? item.amount++ : item.amount--;
      refresh();
    });
  }
}
