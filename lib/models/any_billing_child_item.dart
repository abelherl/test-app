import 'package:flutter/material.dart';

class AnyBillingChildItem {
  final String id;
  final String menuId;
  final String name;
  double price;
  String toppings;
  String notes;
  int amount;

  AnyBillingChildItem({
    @required this.id,
    @required this.menuId,
    @required this.name,
    @required this.price,
    @required this.toppings,
    @required this.notes,
    @required this.amount,
  });
}
