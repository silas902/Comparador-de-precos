import 'package:flutter/material.dart';

class Produto with ChangeNotifier{
  
  final String id;
  final String nomeProduto; 
  final double valorProduto;

  Produto ({
    required this.id,
    required this.nomeProduto,
    required this.valorProduto,
  });
}