import 'package:comparador_de_precos/main.dart';
import 'package:comparador_de_precos/models/dummy_mercado.dart';
import 'package:comparador_de_precos/models/mercado.dart';
import 'package:flutter/material.dart';

class ProdutosDoMercado extends StatelessWidget {
  //static const routeName = '/produtos_do_mercado';

  
  const ProdutosDoMercado();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: ListView.builder(
        itemCount: DETALHES_MERCADO.length,
        itemBuilder: (context, int mercados) {
          return ListTile(
            title: Text(DETALHES_MERCADO[mercados].nomeProduto.toString()),
            subtitle: Text(''),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),              ),
          );
        }             
      )
    );        
  }
}
