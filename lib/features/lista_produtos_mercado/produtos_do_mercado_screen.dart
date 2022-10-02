import 'package:comparador_de_precos/features/lista_mercados/cadastro_produtos_screen.dart';
import 'package:comparador_de_precos/features/lista_mercados/edit_produto_screen.dart';
import 'package:comparador_de_precos/models/mercado.dart';
import 'package:comparador_de_precos/models/produto.dart';
import 'package:comparador_de_precos/providers/mercado_produtos_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProdutosDoMercadoScreen extends StatelessWidget {
  final Mercado mercado;
  const ProdutosDoMercadoScreen(
    this.mercado,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mercado.nome),
        actions: [
          IconButton(
            onPressed:
                () => Navigator.push(context, MaterialPageRoute(builder: (context) => CadastroProdutosScreen(mercadoId: mercado.id,))),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<MercadoProdutosProvider>(
        builder: (context, mercadoProdutosProvider, child) {
          List<Produto> produtosDoMercado =
              mercadoProdutosProvider.produtosDoMercado(mercado.id);
          return ListView.builder(
            itemCount: produtosDoMercado.length,
            itemBuilder: (context, index) {
              final produtoItem = produtosDoMercado[index];
              return ProdutoListItem(
                produto: produtoItem,
                onClick: (produto) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProdutoScreen(
                        produto: produtoItem, mercado: mercado,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ProdutoListItem extends StatelessWidget {
  final Produto produto;
  final Function(Produto) onClick;
  const ProdutoListItem(
      {Key? key, required this.produto, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        margin: const EdgeInsets.all(6),
        color: Colors.grey[200],
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: Text(produto.nomeProduto.toString()),
              subtitle: Text(produto.valorProduto.toString()),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  onClick(produto);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
