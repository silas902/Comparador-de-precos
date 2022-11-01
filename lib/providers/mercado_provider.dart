import 'dart:convert';
import 'package:comparador_de_precos/constants/constants.dart';
import 'package:comparador_de_precos/models/markets.dart';
import 'package:comparador_de_precos/models/product.dart';
import 'package:comparador_de_precos/providers/autenticacao_provider.dart';
import 'package:comparador_de_precos/providers/mercado_produtos_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MercadoProvider extends ChangeNotifier {
  final List<Mercado> _items = [];

  List<Mercado> get items => [..._items];

  bool isLoading = true;
  

  Future<void> carregarMercados(BuildContext context,) async {
    final auth =  Provider.of<AutenticacaoProvider>(context, listen: false);
    _items.clear();
    final response = await http.get(Uri.parse('${Constantes.Url}/${auth.usuario!.uid}.json'));
    Map<String, dynamic> dados = jsonDecode(response.body);
    print(jsonDecode(response.body));

    dados.forEach(
      (mercadoId, mercadoDados) {
        _items.add(
          Mercado(
            produtos: [],
            id: mercadoId,
            nome: mercadoDados['nome'].toString(),
          ),
        );
      },
    );
    //isLoading = false;
    notifyListeners();
  }

  Future<void> addMercado(controllerMercadoNome, context) async {
   final auth =  Provider.of<AutenticacaoProvider>(context, listen: false);
    
    try {
      final response = await http.post(
        Uri.parse('${Constantes.Url}/${auth.usuario!.uid}.json'),
        body: json.encode(
          {
            'nome': controllerMercadoNome,
          },
        ),
      );
       isLoading = false;
      final id = json.decode(response.body)['name'];
      _items.add(
        Mercado(
          id: id,
          nome: controllerMercadoNome,
          produtos: [],
        ),
      );
      notifyListeners();
      Navigator.pop(context);
    } catch (_) {
      _showDialog(context);
    }
  } 

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Ocorreu algum erro!'),
          content: Text('Verifique sua conexão.'),
          actions: [],
        );
      },
    );
  }

  Future<void> editarMercado(Mercado mercado, contralerEditMercado, context) async {
    final auth =  Provider.of<AutenticacaoProvider>(context, listen: false);
    int index = _items.indexWhere((p) => p.id == mercado.id);

    final novoMercado = Mercado(
      id: mercado.id,
      nome: contralerEditMercado,
      produtos: mercado.produtos,
    );

    if (index >= 0) {
      await http.patch(
        Uri.parse('${Constantes.Url}/${auth.usuario!.uid}/${mercado.id}.json'),
        body: jsonEncode(
          {
            'nome': contralerEditMercado,
          },
        ),
      );
      _items[index] = novoMercado;
      notifyListeners();
    }
  }

  Future<void> excluirMercado(Mercado mercado, context) async {
    final auth =  Provider.of<AutenticacaoProvider>(context, listen: false);
    int index = _items.indexWhere((p) => p.id == mercado.id);

    if (index >= 0) {
      final mercado = _items[index];
      _items.remove(mercado);
      notifyListeners();

      final resposta = await http.delete(
        Uri.parse('${Constantes.Url}/${auth.usuario!.uid}/${mercado.id}.json'),
      );
    }
  }
}
