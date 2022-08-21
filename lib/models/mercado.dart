import 'package:flutter/material.dart';

class Mercado extends ChangeNotifier{
  final String? id;
  final String? nome; 
  final String? nomeProduto;
  final double? valorProduto;

  Mercado ({
    this.id,
    this.nome,
    this.nomeProduto,
    this.valorProduto,
  });

 


}