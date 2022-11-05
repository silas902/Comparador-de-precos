import 'package:comparador_de_precos/forms/cadastro_produtos_screen.dart';
import 'package:comparador_de_precos/forms/edit_produto_screen.dart';
import 'package:comparador_de_precos/models/markets.dart';
import 'package:comparador_de_precos/providers/mercado_produtos_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'list_products_card_screen.dart';

class ListProductsScreen extends StatefulWidget {
  final Mercado mercado;
  const ListProductsScreen(this.mercado, {Key? key}) : super(key: key);

  @override
  State<ListProductsScreen> createState() => _ListProductsScreenState();
}

class _ListProductsScreenState extends State<ListProductsScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    context.read<MercadoProdutosProvider>().carregarProdutos(widget.mercado, context).then((value) => setState(() {
      _isLoading = false;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 12, 12),
        title: Text(widget.mercado.nome),
        actions: [
          IconButton(
            onPressed:
                () => Navigator.push(context, MaterialPageRoute(builder: (context) => CadastroProdutosScreen(mercado: widget.mercado,))),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: _isLoading ?  Center(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(240, 179, 178, 178),
                  Color.fromARGB(212, 0, 0, 0),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
            ),
            const Center(child: CircularProgressIndicator())
          ]
        )
      ) : Consumer<MercadoProdutosProvider>(
        builder: (context, mercadoProdutosProvider, child) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(240, 179, 178, 178),
                    Color.fromARGB(212, 0, 0, 0),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
              ),
              RefreshIndicator(
                onRefresh: () async => await mercadoProdutosProvider.carregarProdutos(widget.mercado, context),
                child: ListView.builder(
                  itemCount: mercadoProdutosProvider.items.length,
                  itemBuilder: (context, index) {
                    final produtoItem = mercadoProdutosProvider.items[index]; 
                    return ListProductsCardScreen(
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}