import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:einstein_ai2/helpers/moneyFormat.dart';
import 'package:einstein_ai2/models/Product.dart';
import 'package:einstein_ai2/routes/AppRoutes.dart';
import 'package:einstein_ai2/providers/ProductsProvider.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: null,
      title: Text(this.product.name),
      subtitle: Text('R\$ ' + moneyFormat(this.product.price)),
      trailing: Container(
        width: 96,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.redAccent,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.FORM,
                  arguments: this.product,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.grey.shade500,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Remover produto'),
                    content: Text('Deseja realmente remover o produto?'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Não'),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      FlatButton(
                        child: Text('Sim'),
                        color: Colors.redAccent,
                        textColor: Colors.white,
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
                ).then((confirmed) async {
                  if (confirmed) {
                    await Provider.of<ProductsProvider>(context, listen: false).destroy(this.product.key);
                  }
                });
              },
            ),
          ],
        )
      ),
    );
  }
}