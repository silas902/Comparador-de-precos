import 'package:comparador_de_precos/models/markets.dart';
import 'package:comparador_de_precos/providers/mercado_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MercadoEditSceens extends StatefulWidget {
  final Mercado mercado;
  const MercadoEditSceens({Key? key, required this.mercado}) : super(key: key);

  @override
  State<MercadoEditSceens> createState() => _MercadoEditSceensState();
}

class _MercadoEditSceensState extends State<MercadoEditSceens> {
  late final TextEditingController _controllerEditMercado;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerEditMercado = TextEditingController(text: widget.mercado.nome);
  }

  @override
  Widget build(BuildContext context) {
    final control = Provider.of<MercadoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(251, 231, 180, 12),
        title: const Text('Editar Produto'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              control.editarMercado(
                  widget.mercado, _controllerEditMercado.text, context);
              Navigator.pop(context);
            },
            icon: Icon(Icons.save),
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
            padding: EdgeInsets.all(10),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _controllerEditMercado,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: 'Valor'),
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
