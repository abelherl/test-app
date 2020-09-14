import 'package:flutter/material.dart';

class AnyBillingItem {
  final String id;
  final String subtotal;
  final String grandtotal;
  final String customer;
  final String orderType;
  final bool isActive;
  final bool isPaid;

  AnyBillingItem({
    @required this.id,
    @required this.subtotal,
    @required this.grandtotal,
    @required this.customer,
    @required this.orderType,
    @required this.isActive,
    @required this.isPaid,
  });
}
