import 'package:flutter/material.dart';
import 'package:einstein_ai2/models/Product.dart';
import 'package:einstein_ai2/database.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];

  ProductsProvider() {
    initBD(cb: () async {
      this.load();
    });
  }

  Timer timer;

  void load() async {
    try {
      this._items = await this.loadProducts();
      notifyListeners();

      if (this.timer != null) {
        this.timer.cancel();
      }
    }
    catch(e) {
      this.timer = Timer(Duration(seconds: 2), () => this.load());
    }
  }

  Future<List<Product>> loadProducts() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');

    return List.generate(maps.length, (i) {
      return Product(
        key: maps[i]['key'],
        name: maps[i]['name'],
        price: maps[i]['price'],
      );
    });
  }

  int get count => _items.length;

  Product byIndex(int index) => _items.elementAt(index);

  Future<void> save(Product product) async {
    final Database db = await database;

    await db.insert(
      'products',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    this._items = await this.loadProducts();

    notifyListeners();
  }

  Future<void> destroy(int key) async {
    final Database db = await database;

    await db.delete(
        'products',
        where: 'key = ?',
        whereArgs: [key]
    );

    this._items = await this.loadProducts();

    notifyListeners();
  }
}