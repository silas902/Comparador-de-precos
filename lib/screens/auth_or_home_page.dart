import 'package:comparador_de_precos/screens/authentication/authentication_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/authentication_provider.dart';
import 'markets/list_markets_screen.dart';


class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return context.read<AuthenticationProvider>().isAuth ? const ListMarketsScreen() : const AuthenticationScreen();
  }
}