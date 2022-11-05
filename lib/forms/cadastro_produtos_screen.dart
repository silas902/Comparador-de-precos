import 'package:comparador_de_precos/models/markets.dart';
import 'package:comparador_de_precos/providers/mercado_produtos_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CadastroProdutosScreen extends StatefulWidget {
  final Mercado mercado;
  const CadastroProdutosScreen({Key? key, required this.mercado})
      : super(key: key);

  @override
  State<CadastroProdutosScreen> createState() => _CadastroProdutosScreenState();
}

class _CadastroProdutosScreenState extends State<CadastroProdutosScreen> {
  late final TextEditingController _controllerProduto;
  late final TextEditingController _controllerValor;

  @override
  void initState() {
    super.initState();
    _controllerProduto = TextEditingController();
    _controllerValor = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MercadoProdutosProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Produto'),
        backgroundColor: const Color.fromARGB(255, 12, 12, 12),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.addProduto(_controllerProduto.text,
                  double.parse(_controllerValor.text), widget.mercado, context);
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
                  controller: _controllerProduto,
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
                  controller: _controllerValor,
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
