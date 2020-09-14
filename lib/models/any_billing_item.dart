import 'package:flutter/material.dart';

class AnyBillingItem {
  final String id;
  double subtotal;
  double grandtotal;
  double storeCharge;
  String customer;
  String orderType;
  bool isActive;
  bool isPaid;

  AnyBillingItem({
    @required this.id,
    @required this.subtotal,
    @required this.grandtotal,
    @required this.storeCharge,
    @required this.customer,
    @required this.orderType,
    @required this.isActive,
    @required this.isPaid,
  });
}
