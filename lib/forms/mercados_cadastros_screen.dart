import 'package:comparador_de_precos/providers/mercado_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import '../models/markets.dart';

class MercadoCadastrosScreen extends StatefulWidget {
  @override
  State<MercadoCadastrosScreen> createState() => _MercadoCadastrosScreenState();
}

class _MercadoCadastrosScreenState extends State<MercadoCadastrosScreen> {
  late final TextEditingController _controllerMercadoNome;

  @override
  void initState() {
    super.initState();
    _controllerMercadoNome = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MercadoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 12, 12),
        title: const Text('Cadastro do Mercado'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.addMercado(_controllerMercadoNome.text, context);
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
                    controller: _controllerMercadoNome,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: 'Mercado'),
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
