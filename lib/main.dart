import 'package:comparador_de_precos/screens/auth_or_home_page.dart';
import 'package:comparador_de_precos/providers/authentication_provider.dart';
import 'package:comparador_de_precos/providers/market_product_provider.dart';
import 'package:comparador_de_precos/providers/market_provider.dart';
import 'package:comparador_de_precos/services/market_product_service_http.dart';
import 'package:comparador_de_precos/services/market_service_http.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthenticationProvider(),
        ),
         ChangeNotifierProxyProvider<AuthenticationProvider, MarketProvider>(
          create: (context) => MarketProvider(MarketServiceHttp(userId: '', token: '')),
          update: (context, authentication, previous) {
            return MarketProvider(
              MarketServiceHttp(userId: authentication.userId ?? '', token: authentication.token ?? ''),
            );
          },
        ),
        ChangeNotifierProxyProvider<AuthenticationProvider, MarketProductProvider>(
          create: (context) => MarketProductProvider(MarketProductServiceHttp(userId: '', token: '')),
          update: (context, authentication, previous) {
            return MarketProductProvider(MarketProductServiceHttp(userId: authentication.userId ?? '', token: authentication.token ?? ''),);   
          },
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthOrHomePage(),
      ),
    );
  }
}
