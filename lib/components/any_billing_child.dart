import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:test_app/components/any_menu_grid.dart';
import 'package:test_app/const.dart';
import 'package:test_app/models/any_billing_child_item.dart';
import 'package:test_app/services/data_dummy.dart';

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

  void changeAmount(bool addAmount) async {
    bool delete = false;

    if (!addAmount && item.amount == 1) {
      delete = await showDeleteDialog(context);
    }

    if (delete) {
      print('Deleted');
    }
    else {
      setState(() {
        addAmount ? item.amount++ : item.amount--;
        refresh();
      });
    }
  }

  Future<bool> showDeleteDialog(BuildContext context) async {
    dynamic result = await showDialog(
        context: context,
        builder: (context) {
          return Parent(
            style: ParentStyle()
              ..alignment.center()
              ..maxHeight(200)
              ..width(290)
              ..padding(all: 20)
              ..borderRadius(all: aBorderRadius * 2)
              ..background.color(Colors.white),
            child: Column(
              children: [
                Text(
                  'Item Order',
                  style: aHeader3Style,
                ),
                SizedBox(height: aPadding),
                Expanded(
                  child: Text(
                    'Are you sure you want to\ndelete this item?',
                    textAlign: TextAlign.center,
                    style: aBodyStyle,
                  ),
                ),
                SizedBox(height: aPadding),
                Row(
                  children: [
                    Expanded(
                      child: Txt('No',
                          gesture: Gestures()
                            ..onTap(() => Navigator.pop(context, {'delete': false})),
                          style: TxtStyle()
                            ..padding(all: 10)
                            ..fontFamily(aFontFamily)
                            ..alignmentContent.center()
                            ..fontSize(14)
                            ..textColor(aDarkTextColor)
                            ..bold()
                            ..textDecoration(TextDecoration.none)
                            ..borderRadius(all: aBorderRadius)
                            ..background.color(Colors.transparent)),
                    ),
                    Expanded(
                      child: Txt(
                        'Yes',
                        style: TxtStyle()
                          ..padding(all: 10)
                          ..fontFamily(aFontFamily)
                          ..alignmentContent.center()
                          ..fontSize(14)
                          ..textColor(Colors.white)
                          ..bold()
                          ..textDecoration(TextDecoration.none)
                          ..borderRadius(all: aBorderRadius)
                          ..background.color(aRed),
                        gesture: Gestures()
                          ..onTap(
                            () => Navigator.pop(context, {'delete': true}),
                          ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });

    return result['delete'];
  }
}
