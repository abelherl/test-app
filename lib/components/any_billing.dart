import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:test_app/components/any_button.dart';
import 'package:test_app/const.dart';
import 'package:test_app/models/any_billing_item.dart';

class AnyBilling extends StatefulWidget {
  @override
  _AnyBillingState createState() => _AnyBillingState();
}

class _AnyBillingState extends State<AnyBilling> {
  @override
  Widget build(BuildContext context) {
    var billing = AnyBillingItem(
      id: 'ID-FF78',
      customer: '',
      orderType: 'Dine In',
      subtotal: '300',
      grandtotal: '400',
      isActive: true,
      isPaid: true,
    );

    return Container(
      padding: EdgeInsets.all(aPadding),
      color: Colors.white,
      height: double.maxFinite,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Parent(
                  gesture: Gestures()
                    ..onTap(() {
                    }),
                  style: ParentStyle()
                    ..padding(all: aPadding-5)
                    ..alignmentContent.center()
                    ..borderRadius(all: aBorderRadius)
                    ..background.color(aRed)
                    ..ripple(true),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_circle_outline, color: Colors.white, size: 20,),
                      SizedBox(width: 5),
                      Text(
                        'Add Customer',
                        style: aButtonTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: aPadding),
              Expanded(
                child: Parent(
                  gesture: Gestures()
                    ..onTap(() {
                    }),
                  style: ParentStyle()
                    ..padding(all: aPadding-5)
                    ..alignmentContent.center()
                    ..borderRadius(all: aBorderRadius)
                    ..border(all: 1, color: aBorderColor)
                    ..background.color(aInactiveColor)
                    ..ripple(true),
                  child: Stack(
                    children: [
                      SizedBox(width: double.infinity),
                      Center(
                        child: Text(
                          'Dine In',
                          style: aBodyLightStyle,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: aLightTextColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: aPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                billing.id,
                style: aHeader2Style,
              ),
              Txt(
                billing.isPaid ? 'Paid' : 'Unpaid',
                style: TxtStyle()
                  ..width(100)
                  ..height(30)
                  ..alignmentContent.center()
                  ..fontFamily(aFontFamily)
                  ..fontSize(14)
                  ..fontWeight(FontWeight.w400)
                  ..textColor(billing.isPaid ? aGreen : aRed)
                  ..textDecoration(TextDecoration.none)
                  ..background.color(billing.isPaid ? aLightGreen : aLightRed)
                  ..borderRadius(all: 100),
              )
            ],
          ),
          SizedBox(height: aPadding),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
            ),
          ),
          Divider(
            thickness: 1,
            color: aBorderColor,
          ),
          SizedBox(height: aPadding - 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sub Total',
                style: aBodyLightStyle,
              ),
              Text(
                'SAR ${billing.subtotal}',
                style: aBoldBodyStyle,
              ),
            ],
          ),
          SizedBox(height: aPadding),
          Row(
            children: [
              Text(
                'Discount',
                style: aErrorStyle,
                textAlign: TextAlign.start,
              ),
              SizedBox(width: 5),
              Icon(Icons.add_circle_outline, color: aRed, size: 20,),
            ],
          ),
          SizedBox(height: aPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Store Charge',
                style: aBodyLightStyle,
              ),
              Text(
                'SAR 100',
                style: aBoldBodyStyle,
              ),
            ],
          ),
          SizedBox(height: aPadding * 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Parent(
                  gesture: Gestures()
                    ..onTap(() {
                    }),
                  style: ParentStyle()
                    ..padding(all: aPadding-5)
                    ..alignmentContent.center()
                    ..borderRadius(all: aBorderRadius)
                    ..border(all: 1, color: aBorderColor)
                    ..background.color(aInactiveColor)
                    ..ripple(true),
                  child: Text(
                    'Save Bill',
                    style: aBodyLightStyle,
                  ),
                ),
              ),
              SizedBox(width: aPadding),
              Expanded(
                child: Parent(
                  gesture: Gestures()
                    ..onTap(() {
                    }),
                  style: ParentStyle()
                    ..padding(all: aPadding-5)
                    ..alignmentContent.center()
                    ..borderRadius(all: aBorderRadius)
                    ..border(all: 1, color: aBorderColor)
                    ..background.color(aInactiveColor)
                    ..ripple(true),
                  child: Text(
                    'Print Bill',
                    style: aBodyLightStyle,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: aPadding),
          Parent(
            gesture: Gestures()
              ..onTap(() {
              }),
            style: ParentStyle()
              ..padding(all: aPadding-5)
              ..alignmentContent.center()
              ..borderRadius(all: aBorderRadius)
              ..border(all: 1, color: aBorderColor)
              ..background.color(aInactiveColor)
              ..ripple(true),
            child: Text(
              'Split Bill',
              style: aBodyLightStyle,
            ),
          ),
          SizedBox(height: aPadding),
          AnyButton(title: 'Pay SAR ${billing.grandtotal}', color: aRed, width: aStandardWidth, enabled: true,),
          SizedBox(height: aPadding),
          Divider(
            thickness: 1,
            color: aBorderColor,
          ),
          Parent(
            gesture: Gestures()
              ..onTap(() {
              }),
            style: ParentStyle()
              ..margin(all: aPadding-10, bottom: 0)
              ..alignmentContent.center(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.apps, color: aLightTextColor,),
                SizedBox(width: 5),
                Text(
                  'Custom Amount',
                  style: aBodyLightStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
