import 'package:comparador_de_precos/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationMarketScreen extends StatefulWidget {
  const RegistrationMarketScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationMarketScreen> createState() => _RegistrationMarketScreenState();
}

class _RegistrationMarketScreenState extends State<RegistrationMarketScreen> {
  late final TextEditingController _controllerMarketName;

  @override
  void initState() {
    super.initState();
    _controllerMarketName = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 12, 12),
        title: const Text('Cadastro do Mercado'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<MarketProvider>().addMarket(_controllerMarketName.text, context);
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
                    controller: _controllerMarketName,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Mercado',
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
