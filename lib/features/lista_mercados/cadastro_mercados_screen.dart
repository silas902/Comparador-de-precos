import 'dart:math';

import 'package:comparador_de_precos/providers/mercado_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import '../../models/mercado.dart';

class CadastroMercadosScreen extends StatefulWidget {


  @override
  State<CadastroMercadosScreen> createState() => _CadastroMercadosScreenState();
}

class _CadastroMercadosScreenState extends State<CadastroMercadosScreen> {
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
  /*
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
        onFieldSubmitted: (_) => _saveMercado,
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
 */
  _saveMercado(BuildContext context) {
    final isValid = _formKey.currentState?.validate() ?? false;
     
    _formKey.currentState?.save();

    final newMercado = Mercado(
      id: Random().nextDouble().toString(),
      nome: _formData['nome'] as String,
      //nomeProduto: _formData['nomeProduto'] as String,
      //valorProduto: _formData['valorProduto'] as double,
    ); 
    context.read<MercadoProvider>().addMercado(newMercado);
    Navigator.pop(context);
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
                _saveMercado(context);

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
            children: [fieldNome()],
          ),
        ),
      ),
    );
  }
}
