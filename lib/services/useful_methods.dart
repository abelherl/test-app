import 'dart:io';

import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../const.dart';

void showInSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String value) {
  scaffoldKey.currentState.showSnackBar(
    SnackBar(
      content: Text(value),
      backgroundColor: aRed,
      action: SnackBarAction(
        label: 'DISMISS',
        textColor: Colors.white,
        onPressed: () => SnackBarClosedReason.dismiss,
      ),
    ),
  );
}

Future<bool> showNoNetworkDialog(BuildContext context, String message) async {
  dynamic result = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Parent(
            style: ParentStyle()
              ..alignment.center()
              ..maxHeight(220)
              ..width(290)
              ..padding(all: 20)
              ..borderRadius(all: aBorderRadius * 2)
              ..background.color(Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Network Error',
                  style: aHeader3Style,
                ),
                SizedBox(height: aPadding),
                Expanded(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: aBodyStyle,
                  ),
                ),
                SizedBox(height: aPadding),
                Txt(
                  'Reload',
                  style: TxtStyle()
                    ..padding(all: 10)
                    ..fontFamily(aFontFamily)
                    ..alignmentContent.center()
                    ..fontSize(14)
                    ..textColor(aRed)
                    ..bold()
                    ..textDecoration(TextDecoration.none)
                    ..borderRadius(all: aBorderRadius)
                    ..background.color(Colors.white),
                  gesture: Gestures()
                    ..onTap(
                          () => Navigator.pop(context, {'reload': true}),
                    ),
                ),
              ],
            ),
          ),
        );
      });

  return result['reload'];
}

Future<bool> checkNetwork() async {
  bool connected = false;

  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      connected = true;
    }
  } on SocketException catch (_) {
    print('not connected');
  }

  return connected;
}