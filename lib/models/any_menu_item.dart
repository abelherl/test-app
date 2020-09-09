import 'package:flutter/material.dart';
import 'package:division/division.dart';

class AnyMenuItem {
  final String name;
  final String price;
  final String imageUrl;
  final bool soldOut;

  AnyMenuItem({
    @required this.name,
    @required this.price,
    @required this.imageUrl,
    @required this.soldOut
  });
}
