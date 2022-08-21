import 'package:comparador_de_precos/models/mercado.dart';
import 'package:comparador_de_precos/models/produtos_do_mercodo.dart';
import 'package:flutter/material.dart';
import 'models/dummy_mercado.dart';
import 'models/form-page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Mercado()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
        initialRoute: '/',
        routes: {
          '/form_page': (context) => FormPage(),
          'produtos_do_mercado': (context) => ProdutosDoMercado(),
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    final argumentos = ModalRoute.of(context)!.settings.arguments as Mercado?;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[300],
        title: Text('Comparador de Preços'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/form_page');
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (
          BuildContext context,
          int mercados,
        ) {
          return Consumer(
            builder: (context, storedValue, child) {
              return Container(
                height: 100,
                child: Card(
                  margin: const EdgeInsets.all(6),
                  color: Colors.grey[200],
                  elevation: 10,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, 'produtos_do_mercado');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ListTile(
                          title: (Text(DETALHES_MERCADO[mercados].nome.toString())),
                          subtitle: const Text('Ultimo Acesso:'),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        itemCount: DETALHES_MERCADO.length,
      ),
    );
  }
}
