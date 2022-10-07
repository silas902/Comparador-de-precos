import 'package:comparador_de_precos/providers/mercado_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import '../../models/mercado.dart';

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
        title: Text('Cadastro do Mercado'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              controller.addMercado(_controllerMercadoNome.text, context);  
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
                controller: _controllerMercadoNome,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: 'Mercado'),
              ),  
            ],
          ),
        ),
      ),
    );
  }
}
