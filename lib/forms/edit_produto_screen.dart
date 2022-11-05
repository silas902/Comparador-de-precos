import 'package:comparador_de_precos/models/markets.dart';
import 'package:comparador_de_precos/models/product.dart';
import 'package:comparador_de_precos/providers/mercado_produtos_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProdutoScreen extends StatefulWidget {
  final Produto produto;
  final Mercado mercado;
  const EditProdutoScreen(
      {Key? key, required this.produto, required this.mercado})
      : super(key: key);

  @override
  State<EditProdutoScreen> createState() => _EditProdutoScreenState();
}

class _EditProdutoScreenState extends State<EditProdutoScreen> {
  late final TextEditingController _controllerProduto;
  late final TextEditingController _controllerValor;

  @override
  void initState() {
    super.initState();
    _controllerProduto =
        TextEditingController(text: widget.produto.nomeProduto);
    _controllerValor =
        TextEditingController(text: widget.produto.valorProduto.toString());
  }

  @override
  Widget build(BuildContext context) {
    final control = Provider.of<MercadoProdutosProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 12, 12),
        title: const Text('Editar Produto'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              control.editarProduto(widget.produto, widget.mercado,
                  _controllerProduto.text, double.parse(_controllerValor.text));
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
                    controller: _controllerProduto,
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
        ],
      ),
    );
  }
}
