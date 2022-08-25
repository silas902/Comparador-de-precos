import 'package:comparador_de_precos/models/mercado.dart';
import 'package:comparador_de_precos/models/produto.dart';
import 'package:comparador_de_precos/providers/mercado_produtos_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProdutosDoMercadoScreen extends StatelessWidget {
  final Mercado mercado;

  const ProdutosDoMercadoScreen(this.mercado);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      body: Container(
        child: Consumer<MercadoProdutosProvider>(builder: (context, mercadoProdutosProvider, child) {
          List<Produto> produtosDoMercado = mercadoProdutosProvider.produtosDoMercado(mercado.id);
          return ListView.builder(
            itemCount: produtosDoMercado.length,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(produtosDoMercado[index].nome.toString()),
                subtitle: Text(produtosDoMercado[index].valorProduto.toString()),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                ),
              );
              Divider();
            },
            //itemCount: DETALHES_MERCADO,
          );
        }),
      ),
      appBar: AppBar(
        title: Text(mercado.nome),
      ),
    );
  }
}
    
    
    //Scaffold(
        //appBar: AppBar(
        //  title: Text(''),
        //),
        //body: Consumer<Mercado>(
        //  builder: (context, mercado, child) {
        //    return ListView.builder(
        //      itemCount: listMercado,
        //      itemBuilder: (context, int mercados) {
        //        return ListTile(
        //          title:
        //              Text(DETALHES_MERCADO[mercados].nomeProduto.toString()),
        //          subtitle: Text(''),
        //          trailing: IconButton(
        //            onPressed: () {},
        //            icon: const Icon(Icons.delete),
        //          ),
        //        );
        //      },
        //    );
        //  },
        //));
