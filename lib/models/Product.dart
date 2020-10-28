import 'package:flutter/foundation.dart';

class Product {
  final int key;
  final String name;
  final double price;

  const Product({
    this.key,
    @required this.name,
    @required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'key': this.key,
      'name': this.name,
      'price': this.price,
    };
  }
}