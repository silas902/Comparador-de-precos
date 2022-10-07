import 'package:comparador_de_precos/models/mercado.dart';
import 'package:comparador_de_precos/models/produto.dart';
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
    // TODO: implement initState
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
        title: const Text('Editar Produto'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              control.pp(_controllerProduto.text, double.parse(_controllerValor.text), widget.mercado, widget.produto.id);
              Navigator.pop(context);
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _controllerProduto,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: 'Valor'),
              ),
              TextFormField(
                controller: _controllerValor,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Valor'),
              ),
            ],
          ),

          //key: _formKey,
        ),
      ),
    );
  }
}
