import 'package:comparador_de_precos/models/markets.dart';
import 'package:comparador_de_precos/models/product.dart';
import 'package:comparador_de_precos/providers/market_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListProductsCardScreen extends StatelessWidget {
  final Product product;
  final Marketplace marketplace;
  final Function(Product) onClick;
  const ListProductsCardScreen({Key? key, required this.product, required this.onClick, required this.marketplace}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: UniqueKey(),
      background: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(7),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget> [
            Icon(Icons.delete, size: 30,),
          ],
        ),    
      ),
      confirmDismiss: (direction ) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Deseja Excluir o Produto ${product.productName} ?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Não'),
              ),
              TextButton(onPressed: () {
                context.read<MarketProductProvider>().deleteProduct(product, marketplace);
                Navigator.pop(context);
              }, child: const Text('Sim')),
            ],
          ),
        );
      },
      child: SizedBox(
        height: 100,
        child: Card(
          color: Colors.black38,
          margin: const EdgeInsets.all(6),
          elevation: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: Text(product.productName.toString(), style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic)),
                subtitle: Text(product.productValue.toString(), style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic)),
                trailing: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    onClick(product);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}