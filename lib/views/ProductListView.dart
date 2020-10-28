import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:einstein_ai2/components/ProductTile.dart';
import 'package:einstein_ai2/providers/ProductsProvider.dart';
import 'package:einstein_ai2/routes/AppRoutes.dart';

  class ProductListView extends StatefulWidget {
  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  @override
  Widget build(BuildContext context) {
    final ProductsProvider products = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
        centerTitle: false,
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(4),
                  itemCount: products.count,
                  itemBuilder: (ctx, i) => ProductTile(products.byIndex(i)),
                  separatorBuilder: (BuildContext ctx, int index) => const Divider(),
                ),
              ),
            ],
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.FORM);
        },
        backgroundColor: Colors.red.shade800,
        foregroundColor: Colors.white,
        tooltip: 'Adicionar produto',
        child: Icon(Icons.add),
      ),
    );
  }
}