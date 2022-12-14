import 'package:comparador_de_precos/forms/market_edit_screens.dart';
import 'package:comparador_de_precos/models/markets.dart';
import 'package:comparador_de_precos/providers/authentication_provider.dart';
import 'package:comparador_de_precos/screens/markets/list_markets_card_widget.dart';
import 'package:comparador_de_precos/forms/registration_market_screen.dart';
import 'package:comparador_de_precos/providers/market_provider.dart';
import 'package:comparador_de_precos/screens/products/list_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListMarketsScreen extends StatefulWidget {
  const ListMarketsScreen({Key? key}) : super(key: key);

  @override
  State<ListMarketsScreen> createState() => _ListMarketsScreenState();
}

class _ListMarketsScreenState extends State<ListMarketsScreen> {
  bool _isLoading = true;

  //void _showDialog(BuildContext context) {
  //  showDialog(
  //    context: context,
  //    builder: (BuildContext context) {
  //      return const AlertDialog(
  //        title: Text('Ocorreu Algum Erro!'),
  //        content: Text('Verifique sua Conexão.'),
  //      );
  //    },
  //  );
  //}

  @override
  void initState() {
    super.initState();
    Provider.of<MarketProvider>(context, listen: false)
        .loadMarkets()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 12, 12),
        title: const Text('Comparador de Preços'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegistrationMarketScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              Provider.of<AuthenticationProvider>(
                context,
                listen: false,
              ).logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: Stack(children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(240, 179, 178, 178),
                    Color.fromARGB(212, 0, 0, 0),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
              ),
              Center(
                  child: RefreshIndicator(
                    child: const CircularProgressIndicator(),
                    onRefresh: () async => await Provider.of<MarketProvider>(
                            context,
                            listen: false)
                        .loadMarkets()))
            ]))
          : Consumer<MarketProvider>(builder: (context, marketProvider, child) {
              return Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(240, 179, 178, 178),
                        Color.fromARGB(212, 0, 0, 0),
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    ),
                  ),
                  RefreshIndicator(
                    onRefresh: () async => await Provider.of<MarketProvider>(
                      context,
                      listen: false,
                    ).loadMarkets(),
                    child: ListView.builder(
                      itemCount: marketProvider.items.length,
                      itemBuilder: (context, index) {
                        Marketplace marketplace = marketProvider.items[index];
                        return ListMarketsCardWidget(
                          marketplace: marketplace,
                          onClickDeleteMarket: () => marketProvider.deleteMarket(marketId: marketplace.id),
                          onClickEditMarket: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MarketEditSceens(marketplace: marketplace))),
                          onClick: () =>  Navigator.push(context,MaterialPageRoute(builder: (context) => ListProductsScreen(marketplace))),
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
    );
  }
}
