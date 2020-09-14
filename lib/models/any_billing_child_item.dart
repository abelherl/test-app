import 'package:flutter/material.dart';

class AnyBillingChildItem {
  final String id;
  final String name;
  String total;
  String toppings;
  String notes;
  int amount;

  AnyBillingChildItem({
    @required this.id,
    @required this.name,
    @required this.total,
    @required this.toppings,
    @required this.notes,
    @required this.amount,
  });
}
