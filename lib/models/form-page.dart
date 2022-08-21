import 'dart:math';

import 'package:comparador_de_precos/models/dummy_mercado.dart';
import 'package:flutter/material.dart';
import '../models/mercado.dart';

class FormPage extends StatefulWidget {


  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final _formData = Map<String, Object>();
  

  Widget fieldNome() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nome do Mercado:'),
      textInputAction: TextInputAction.next,
      onSaved: (nome) => _formData['nome'] = nome ?? '',
      validator: (_nome) {
        final nome = _nome ?? '';

        if (nome.trim().isEmpty) {
          return 'Nome é Obrigatório!*';
        }

        if (nome.trim().length < 3) {
          return 'Nome Precisa no Minimo de 3 Letras!*';
        }
        return null;
      },
    );
  }

  Widget fieldProduto() {
    return TextFormField(
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
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: 'Valor'),
        onFieldSubmitted: (_) => _submitForm(),
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
        });
  }

  _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;


    //if (isValid) {
      
    _formKey.currentState?.save();

    final newMercado = Mercado(
      id: Random().nextDouble().toString(),
      nome: _formData['nome'] as String,
      nomeProduto: _formData['nomeProduto'] as String,
      valorProduto: _formData['valorProduto'] as double,

    ); 
  }

  void saveMercado() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro do Mercado'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                _submitForm;
              });             
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
            children: [fieldNome(), fieldProduto(), fieldValor()],
          ),
        ),
      ),
    );
  }
}
