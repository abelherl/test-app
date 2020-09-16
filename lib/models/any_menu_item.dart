import 'package:flutter/material.dart';

class AnyMenuItem {
  final String id;
  final String name;
  final String price;
  final String description;
  final String category;
  final String imageUrl;
  final bool soldOut;

  AnyMenuItem({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.description,
    @required this.category,
    @required this.imageUrl,
    @required this.soldOut
  });
}
