import 'package:comparador_de_precos/forms/registration_products_screen.dart';
import 'package:comparador_de_precos/forms/edit_products_screen.dart';
import 'package:comparador_de_precos/models/markets.dart';
import 'package:comparador_de_precos/providers/market_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'list_products_card_screen.dart';

class ListProductsScreen extends StatefulWidget {
  final Marketplace marketplace;
  const ListProductsScreen(this.marketplace, {Key? key}) : super(key: key);

  @override
  State<ListProductsScreen> createState() => _ListProductsScreenState();
}

class _ListProductsScreenState extends State<ListProductsScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    context.read<MarketProductProvider>().loadProducts(widget.marketplace.id).then((value) => setState(() {_isLoading = false;}));        
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 12, 12),
        title: Text(widget.marketplace.name),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegistrationProductsScreen(
                    mercado: widget.marketplace,
                  ),
                )),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: Stack(children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(240, 179, 178, 178),
                    Color.fromARGB(212, 0, 0, 0),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
              ),
              const Center(child: CircularProgressIndicator())
            ]))
          : Consumer<MarketProductProvider>(
              builder: (context, mercadoProdutosProvider, child) {
                return Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(240, 179, 178, 178),
                              Color.fromARGB(212, 0, 0, 0),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      ),
                    ),
                    RefreshIndicator(
                      onRefresh: () async => await mercadoProdutosProvider
                          .loadProducts(widget.marketplace.id),
                      child: ListView.builder(
                        itemCount: mercadoProdutosProvider.items.length,
                        itemBuilder: (context, index) {
                          final produtoItem =
                              mercadoProdutosProvider.items[index];
                          return ListProductsCardScreen(
                            marketplace: widget.marketplace,
                            product: produtoItem,
                            onClick: (produto) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProductsScreen(
                                    product: produtoItem,
                                    marketplace: widget.marketplace,
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
