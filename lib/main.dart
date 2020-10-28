import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:einstein_ai2/providers/ProductsProvider.dart';
import 'package:einstein_ai2/routes/AppRoutes.dart';
import 'package:einstein_ai2/views/ProductFormView.dart';
import 'package:einstein_ai2/views/ProductListView.dart';
import 'database.dart';

ProductsProvider productsProvider;
void main() {
  productsProvider = ProductsProvider();
  initBD(cb: () {
    productsProvider.load();
  });
  runApp(ProdutosApp());
}

class ProdutosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => productsProvider,
        ),
      ],
      child: MaterialApp(
        title: 'Produtos',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          AppRoutes.HOME: (_) => ProductListView(),
          AppRoutes.FORM: (_) => ProductFormView(),
        },
      ),
    );
  }
}
