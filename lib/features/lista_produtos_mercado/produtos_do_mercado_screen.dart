import 'package:comparador_de_precos/features/formularios/cadastro_produtos_screen.dart';
import 'package:comparador_de_precos/features/formularios/edit_produto_screen.dart';
import 'package:comparador_de_precos/models/mercado.dart';
import 'package:comparador_de_precos/models/produto.dart';
import 'package:comparador_de_precos/providers/mercado_produtos_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProdutosDoMercadoScreen extends StatefulWidget {
  final Mercado mercado;
  const ProdutosDoMercadoScreen(
    this.mercado,
  );

  @override
  State<ProdutosDoMercadoScreen> createState() => _ProdutosDoMercadoScreenState();
}

class _ProdutosDoMercadoScreenState extends State<ProdutosDoMercadoScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<MercadoProdutosProvider>(context, listen: false).carregarProdutos(widget.mercado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mercado.nome),
        actions: [
          IconButton(
            onPressed:
                () => Navigator.push(context, MaterialPageRoute(builder: (context) => CadastroProdutosScreen(mercado: widget.mercado,))),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<MercadoProdutosProvider>(
        builder: (context, mercadoProdutosProvider, child) {
          List<Produto> produtosDoMercado = widget.mercado.produtos;
          return ListView.builder(
            itemCount: mercadoProdutosProvider.items.length,
            itemBuilder: (context, index) {
              final produtoItem = mercadoProdutosProvider.items[index];
              return ProdutoListItem(
                mercado: widget.mercado,
                produto: produtoItem,
                onClick: (produto) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProdutoScreen(
                        produto: produtoItem, mercado: widget.mercado,
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
  final Mercado mercado;
  final Function(Produto) onClick;
  const ProdutoListItem(
      {Key? key, required this.produto, required this.onClick, required this.mercado})
      : super(key: key);

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
                Provider.of<MercadoProdutosProvider>(context, listen: false).excluirProduto(produto, mercado);
                Navigator.pop(context);
              }, child: const Text('Sim')),
            ],
          ),
        );
      },
      child: Container(
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
      ),
    );
  }
}
