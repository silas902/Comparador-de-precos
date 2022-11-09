import 'package:comparador_de_precos/models/markets.dart';
import 'package:comparador_de_precos/providers/market_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationProductsScreen extends StatefulWidget {
  final Marketplace mercado;
  const RegistrationProductsScreen({Key? key, required this.mercado})
      : super(key: key);

  @override
  State<RegistrationProductsScreen> createState() => _RegistrationProductsScreenState();
}

class _RegistrationProductsScreenState extends State<RegistrationProductsScreen> {
  late final TextEditingController _controllerProduct;
  late final TextEditingController _controllerValue;

  @override
  void initState() {
    super.initState();
    _controllerProduct = TextEditingController();
    _controllerValue = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MarketProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Produto'),
        backgroundColor: const Color.fromARGB(255, 12, 12, 12),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.addProduct(_controllerProduct.text,
                  double.parse(_controllerValue.text), widget.mercado, context);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Stack(children: [
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
                    labelText: 'Produto',
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
      ]),
    );
  }
}
