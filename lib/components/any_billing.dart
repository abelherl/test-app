import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:test_app/components/any_billing_child.dart';
import 'package:test_app/const.dart';
import 'package:test_app/models/any_billing_item.dart';
import 'package:test_app/services/data_dummy.dart';

class AnyBilling extends StatefulWidget {
  AnyBilling({@required this.parentState});

  final State parentState;

  @override
  _AnyBillingState createState() => _AnyBillingState(parentState);
}

class _AnyBillingState extends State<AnyBilling> {
  _AnyBillingState(this.parentState);

  final State parentState;
  bool hidePayment = true;
  bool pressed = false;
  var billing = AnyBillingItem(
    id: 'ID-FF78',
    customer: '',
    orderType: 'Dine In',
    subtotal: 300,
    storeCharge: 100,
    grandtotal: 400,
    isActive: true,
    isPaid: true,
  );

  @override
  void initState() {
    super.initState();
    getPaymentInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Parent(
        style: ParentStyle()
          ..height(double.infinity)
          ..maxWidth(350)
          ..minWidth(300)
          ..background.color(Colors.white),
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
      ),
    );
  }

  void getPaymentInfo() {
    double total = 0;
    dummyBilling.forEach((item) {
      total += item.price * item.amount;
    });

    setState(() {
      billing.subtotal = total;
      billing.grandtotal = total + billing.storeCharge;
    });
  }

  Expanded _buildListAndExpandButton() {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ListView(
            padding: EdgeInsets.symmetric(horizontal: aPadding),
            physics: BouncingScrollPhysics(),
            children: dummyBilling.map((item) {
              return Parent(
                gesture: Gestures()..onTap(() => getPaymentInfo()),
                child: Column(
                  children: [
                    AnyBillingChild(
                      item: item,
                      refresh: getPaymentInfo,
                    ),
                    Divider(
                      thickness: 1,
                      color: aBorderColor,
                    ),
                  ],
                ),
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
              child: Icon(
                hidePayment
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Parent _buildBillingPaymentContainer(AnyBillingItem billing) {
    return Parent(
      style: ParentStyle()
        ..background.color(Colors.white)
        ..height(hidePayment ? 0 : 240)
        ..animate(500, Curves.easeOutQuart),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: aPadding),
        child: Column(
          children: [
            Container(height: 1, color: aBorderColor),
            SizedBox(height: aPadding),
            _buildBillingPayment('Sub Total', '${billing.subtotal}'),
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
            _buildBillingPayment('Store Charge', '${billing.storeCharge}'),
            SizedBox(height: aPadding * 2),
            _buildBillingSaveAndPrint(),
            SizedBox(height: aPadding),
            Txt(
              'Pay SAR ${billing.grandtotal}',
              gesture: Gestures()
                ..isTap((isTapped) => setState(() => pressed = isTapped))
                ..onTap(() {}),
              style: TxtStyle()
                ..opacity(1)
                ..width(aStandardWidth)
                ..padding(all: aPadding)
                ..textColor(Colors.white)
                ..alignmentContent.center()
                ..borderRadius(all: aBorderRadius)
                ..background.color(aRed)
                ..elevation(pressed ? 0 : 5, color: aRed)
                ..scale(pressed ? 0.95 : 1)
                ..animate(400, Curves.easeOutQuart)
                ..ripple(true),
            ),
          ],
        ),
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

  Padding _buildBillingSaveAndPrint() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Parent(
              gesture: Gestures()..onTap(() {}),
              style: ParentStyle()
                ..padding(all: aPadding - 8)
                ..alignmentContent.center()
                ..borderRadius(all: aBorderRadius)
                ..border(all: 1, color: aBorderColor)
                ..background.color(aInactiveColor)
                ..ripple(true),
              child: Text(
                'Save',
                style: aBodyLightStyle,
              ),
            ),
          ),
          SizedBox(width: aPadding),
          Expanded(
            child: Parent(
              gesture: Gestures()..onTap(() {}),
              style: ParentStyle()
                ..padding(all: aPadding - 8)
                ..alignmentContent.center()
                ..borderRadius(all: aBorderRadius)
                ..border(all: 1, color: aBorderColor)
                ..background.color(aInactiveColor)
                ..ripple(true),
              child: Text(
                'Split',
                style: aBodyLightStyle,
              ),
            ),
          ),
          SizedBox(width: aPadding),
          Expanded(
            child: Parent(
              gesture: Gestures()..onTap(() {}),
              style: ParentStyle()
                ..padding(all: aPadding - 8)
                ..alignmentContent.center()
                ..borderRadius(all: aBorderRadius)
                ..border(all: 1, color: aBorderColor)
                ..background.color(aInactiveColor)
                ..ripple(true),
              child: Text(
                'Print',
                style: aBodyLightStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildBillingPayment(String title, String amount) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Row(
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
      ),
    );
  }

  Padding _buildBillingInfo(AnyBillingItem billing) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: aPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            billing.id,
            style: aHeader3Style,
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
    );
  }

  Padding _buildBillingHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: aPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Parent(
              gesture: Gestures()..onTap(() {}),
              style: ParentStyle()
                ..padding(all: aPadding - 8)
                ..alignmentContent.center()
                ..borderRadius(all: aBorderRadius + 2)
                ..background.color(aRed)
                ..ripple(true),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                    size: 16,
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
                ..padding(all: aPadding - 8)
                ..alignmentContent.center()
                ..borderRadius(all: aBorderRadius + 2)
                ..border(all: 1, color: aBorderColor)
                ..background.color(aInactiveColor)
                ..ripple(true),
              child: Stack(
                children: [
                  SizedBox(width: double.infinity),
                  Center(
                    child: Text(
                      'Dine In',
                      style: aSmallBodyLightStyle,
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
    );
  }
}
