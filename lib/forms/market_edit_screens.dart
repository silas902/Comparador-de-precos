import 'package:comparador_de_precos/models/markets.dart';
import 'package:comparador_de_precos/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarketEditSceens extends StatefulWidget {
  final Marketplace marketplace;
  const MarketEditSceens({Key? key, required this.marketplace}) : super(key: key);

  @override
  State<MarketEditSceens> createState() => _MarketEditSceensState();
}

class _MarketEditSceensState extends State<MarketEditSceens> {
  late final TextEditingController _controllerEditMarket;

  @override
  void initState() {
    super.initState();
    _controllerEditMarket = TextEditingController(text: widget.marketplace.name);
  }

  @override
  Widget build(BuildContext context) {
    final control = Provider.of<MarketProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 12, 12),
        title: const Text('Editar Produto'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              control.editMarket( marketName: _controllerEditMarket.text, marketId: widget.marketplace.id);
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
                    controller: _controllerEditMarket,
                    keyboardType: TextInputType.text,
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
