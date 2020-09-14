import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:test_app/components/any_billing_child.dart';
import 'package:test_app/components/any_button.dart';
import 'package:test_app/const.dart';
import 'package:test_app/models/any_billing_item.dart';
import 'package:test_app/services/data_dummy.dart';

class AnyBilling extends StatefulWidget {
  @override
  _AnyBillingState createState() => _AnyBillingState();
}

class _AnyBillingState extends State<AnyBilling> {
  bool hidePayment = true;
  var billing = AnyBillingItem(
    id: 'ID-FF78',
    customer: '',
    orderType: 'Dine In',
    subtotal: '300',
    grandtotal: '400',
    isActive: true,
    isPaid: true,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: aPadding),
      color: Colors.white,
      height: double.maxFinite,
      child: Column(
        children: [
          SizedBox(height: aPadding),
          _buildBillingHeader(),
          SizedBox(height: aPadding),
          _buildBillingInfo(billing),
          SizedBox(height: aPadding),
          _buildListAndExpandButton(),
          _buildBillingPaymentContainer(billing),
          SizedBox(height: aPadding),
          _buildBillingCustomAmount(),
        ],
      ),
    );
  }

  Expanded _buildListAndExpandButton() {
    return Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              ListView(
                padding: EdgeInsets.only(bottom: 0),
                physics: BouncingScrollPhysics(),
                children: dummyBilling.map((item) {
                  return Column(
                    children: [
                      AnyBillingChild(item: item),
                      Divider(
                        thickness: 1,
                        color: aBorderColor,
                      ),
                    ],
                  );
                }).toList(),
              ),
              Positioned(
                bottom: 0,
                child: Parent(
                  gesture: Gestures()
                    ..onTap(() => setState(() => hidePayment = !hidePayment)),
                  style: ParentStyle()
                    ..width(30)
                    ..height(20)
                    ..borderRadius(topLeft: 5, topRight: 5)
                    ..background.color(aRed)
                    ..alignmentContent.center(),
                  child: Icon(hidePayment ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.white,),
                ),
              ),
            ],
          ),
        );
  }

  Parent _buildBillingPaymentContainer(AnyBillingItem billing) {
    return Parent(
      style: ParentStyle()
        ..height(hidePayment ? 0 : 300)
        ..animate(500, Curves.easeOutQuart),
      child: Column(
        children: [
          SizedBox(height: aPadding),
          _buildBillingPayment('Sub Total', billing.subtotal),
          SizedBox(height: aPadding),
          Row(
            children: [
              Text(
                'Discount',
                style: aErrorStyle,
                textAlign: TextAlign.start,
              ),
              SizedBox(width: 5),
              Icon(
                Icons.add_circle_outline,
                color: aRed,
                size: 20,
              ),
            ],
          ),
          SizedBox(height: aPadding),
          _buildBillingPayment('Store Charge', '100'),
          SizedBox(height: aPadding * 2),
          _buildBillingSaveAndPrint(),
          SizedBox(height: aPadding),
          _buildBillingSplitBill(),
          SizedBox(height: aPadding),
          AnyButton(
            title: 'Pay SAR ${billing.grandtotal}',
            color: aRed,
            width: aStandardWidth,
            enabled: true,
          ),
        ],
      ),
    );
  }

  Parent _buildBillingCustomAmount() {
    return Parent(
      gesture: Gestures()..onTap(() {}),
      style: ParentStyle()
        ..width(double.infinity)
        ..background.color(Colors.white)
        ..padding(all: aPadding - 10, bottom: aPadding)
        ..alignmentContent.center(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.apps,
            color: aLightTextColor,
          ),
          SizedBox(width: 5),
          Text(
            'Custom Amount',
            style: aBodyLightStyle,
          ),
        ],
      ),
    );
  }

  Parent _buildBillingSplitBill() {
    return Parent(
      gesture: Gestures()..onTap(() {}),
      style: ParentStyle()
        ..padding(all: aPadding - 5)
        ..alignmentContent.center()
        ..borderRadius(all: aBorderRadius)
        ..border(all: 1, color: aBorderColor)
        ..background.color(aInactiveColor)
        ..ripple(true),
      child: Text(
        'Split Bill',
        style: aBodyLightStyle,
      ),
    );
  }

  Row _buildBillingSaveAndPrint() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Parent(
            gesture: Gestures()..onTap(() {}),
            style: ParentStyle()
              ..padding(all: aPadding - 5)
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
            gesture: Gestures()..onTap(() {}),
            style: ParentStyle()
              ..padding(all: aPadding - 5)
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
    );
  }

  Row _buildBillingPayment(String title, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: aBodyLightStyle,
        ),
        Text(
          'SAR $amount',
          style: aBoldBodyStyle,
        ),
      ],
    );
  }

  Row _buildBillingInfo(AnyBillingItem billing) {
    return Row(
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
    );
  }

  Row _buildBillingHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Parent(
            gesture: Gestures()..onTap(() {}),
            style: ParentStyle()
              ..padding(all: aPadding - 5)
              ..alignmentContent.center()
              ..borderRadius(all: aBorderRadius)
              ..background.color(aRed)
              ..ripple(true),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                  size: 20,
                ),
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
            gesture: Gestures()..onTap(() {}),
            style: ParentStyle()
              ..padding(all: aPadding - 5)
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
    );
  }
}
