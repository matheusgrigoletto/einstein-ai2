import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:einstein_ai2/providers/ProductsProvider.dart';
import 'package:einstein_ai2/routes/AppRoutes.dart';
import 'package:einstein_ai2/views/ProductFormView.dart';
import 'package:einstein_ai2/views/ProductListView.dart';

void main() {
  runApp(MeusProdutosApp());
}

class MeusProdutosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Meus Produtos',
        theme: ThemeData(
          primarySwatch: Colors.grey.shade800,
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
