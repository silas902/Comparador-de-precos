import 'package:comparador_de_precos/models/markets.dart';
import 'package:comparador_de_precos/models/product.dart';
import 'package:comparador_de_precos/providers/mercado_produtos_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListProductsCardScreen extends StatelessWidget {
  final Produto produto;
  final Mercado mercado;
  final Function(Produto) onClick;
  const ListProductsCardScreen({Key? key, required this.produto, required this.onClick, required this.mercado}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MercadoProdutosProvider>(context, listen: false);
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: UniqueKey(),
      background: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(7),
        padding: const EdgeInsets.all(10),
        //color: Colors.grey,
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
            title: Text('Deseja Excluir o Produto ${produto.nomeProduto} ?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Não'),
              ),
              TextButton(onPressed: () {
                provider.excluirProduto(produto, mercado);
                Navigator.pop(context);
              }, child: const Text('Sim')),
            ],
          ),
        );
      },
      child: Container(
        height: 100,
        child: Card(
          color: Colors.black38,
          margin: const EdgeInsets.all(6),
          elevation: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: Text(produto.nomeProduto.toString(), style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic)),
                subtitle: Text(produto.valorProduto.toString(), style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic)),
                trailing: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    onClick(produto);
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