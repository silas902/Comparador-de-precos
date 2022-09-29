import 'dart:math';

import 'package:comparador_de_precos/models/produto.dart';
import 'package:comparador_de_precos/providers/mercado_produtos_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CadastroProdutosScreen extends StatelessWidget {
  CadastroProdutosScreen({required this.mercadoId, required this.produto});
  final String mercadoId;
  final Produto produto;

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  void initFormData() {
    if (_formData.isEmpty) {
      _formData['id'] = produto.id;
      _formData['nomeProduto'] = produto.nomeProduto;
      _formData['valorProduto'] = produto.valorProduto;
    }
  }

  Widget fieldProduto() {
    return TextFormField(
      initialValue: (_formData['nomeProduto'] ?? '') as String,
      decoration: InputDecoration(labelText: 'Produto:'),
      textInputAction: TextInputAction.next,
      onSaved: (nomeProduto) => _formData['nomeProduto'] = nomeProduto ?? '',
      validator: (_nomeProduto) {
        final nomeProduto = _nomeProduto ?? '';

        if (nomeProduto.trim().isEmpty) {
          return 'Produto é Obrigatório!*';
        }

        if (nomeProduto.trim().length < 3) {
          return 'Produto Precisa no Minimo de 3 Letras!*';
        }

        return null;
      },
    );
  }

  Widget fieldValor() {
    return TextFormField(
      initialValue: ((_formData['valorProduto'] ?? 0.00) as double).toString(),
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(labelText: 'Valor'),
      onFieldSubmitted: (_) => {}, //saveProduto,
      onSaved: (valorProduto) =>
          _formData['valorProduto'] = double.parse(valorProduto ?? '0'),
      validator: (_valorProduto) {
        final valorProdutoString = _valorProduto ?? '';
        final valorProduto = double.tryParse(valorProdutoString) ?? -1;
        if (valorProdutoString.trim().isEmpty) {
          return 'Valor é Obrigatório!*';
        }
        if (valorProduto <= 0) {
          return 'Informe um Preço Válido!*';
        }
        return null;
      },
    );
  }

  void saveProduto(String mercadoId, BuildContext context) {
    bool hasId = _formData['id'] != null;
    _formKey.currentState?.save();

    final newProduto = Produto(
      id: hasId ? _formData['id'] as String : Random().nextDouble().toString(),
      nomeProduto: _formData['nomeProduto'] as String,
      valorProduto: _formData['valorProduto'] as double,
    );

    if (hasId) {
      context.read<MercadoProdutosProvider>().updateProduto(newProduto, mercadoId);
    } else {
      context.read<MercadoProdutosProvider>().addProduto(produto, mercadoId);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    initFormData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro do Produto'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              saveProduto(mercadoId, context);
              Navigator.pop(context);
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [fieldProduto(), fieldValor()],
          ),
        ),
      ),
    );
  }
}