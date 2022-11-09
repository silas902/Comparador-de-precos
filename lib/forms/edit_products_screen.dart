import 'package:comparador_de_precos/models/markets.dart';
import 'package:comparador_de_precos/models/product.dart';
import 'package:comparador_de_precos/providers/market_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProductsScreen extends StatefulWidget {
  final Product product;
  final Marketplace marketplace;
  const EditProductsScreen(
      {Key? key, required this.product, required this.marketplace})
      : super(key: key);

  @override
  State<EditProductsScreen> createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  late final TextEditingController _controllerProduct;
  late final TextEditingController _controllerValue;

  @override
  void initState() {
    super.initState();
    _controllerProduct =
        TextEditingController(text: widget.product.productName);
    _controllerValue =
        TextEditingController(text: widget.product.productValue.toString());
  }

  @override
  Widget build(BuildContext context) {
    final control = Provider.of<MarketProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 12, 12),
        title: const Text('Editar Produto'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              control.editProduct(widget.product, widget.marketplace,
                  _controllerProduct.text, double.parse(_controllerValue.text));
              Navigator.pop(context);
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(240, 179, 178, 178),
                Color.fromARGB(212, 0, 0, 0),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    cursorColor: Colors.black,
                    controller: _controllerProduct,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Valor',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextFormField(
                    cursorColor: Colors.black,
                    controller: _controllerValue,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Valor',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
