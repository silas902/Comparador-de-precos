// ignore_for_file: constant_identifier_names


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/autenticacao_provider.dart';

enum ModoFormulario { Registrar, Login} 

class FormularioAutenticacao extends StatefulWidget {
  const FormularioAutenticacao();

  @override
  State<FormularioAutenticacao> createState() => _FormularioAutenticacaoState();
}

class _FormularioAutenticacaoState extends State<FormularioAutenticacao> {
  late final TextEditingController _controllerEmail;
  late final TextEditingController _controllerSenha;
  final formKey = GlobalKey<FormState>();

  final ModoFormulario _modoFormulario = ModoFormulario.Login;
  
  bool isLogin = true;
  late final String titulo;
  late String actionButton;
  late String toggleButton;

  @override
  void initState(){
    
   // Firebase.initializeApp().whenComplete(() {
      if (mounted) { 
        setState(() {
          
        }); 
        super.initState();
      } 
    //},);
    setFormAction(true);
    

    _controllerEmail = TextEditingController();
    _controllerSenha = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controllerEmail.dispose();
    _controllerSenha.dispose();
  }



  setFormAction(bool acao) {
    if (mounted) { 
      setState(() {    
        isLogin = acao;
        if(isLogin) {
          //titulo = 'Bem vindo';
          actionButton = 'Login';
          toggleButton = 'Cadastre-se';
        } else {
         // titulo = 'Crie uma conta';
          actionButton = 'Cadastrar';
          toggleButton = 'Voltar ao Login';
        }
      });
    }  
  }

  Future<void> login() async {
    try{
      await context.read<AutenticacaoProvider>().login(_controllerEmail.text, _controllerSenha.text); //login(_controllerEmail.text, _controllerSenha.text);
    } on execessaoAutenticacao catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  Future<void> registrar() async {
    try{
      await context.read<AutenticacaoProvider>().registrar(_controllerEmail.text, _controllerSenha.text);
    } on execessaoAutenticacao catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }


  //
  //@override
  //
  //void initState() {
  //
  //  // TODO: implement initState
  //
  //  super.initState();
  //
  //  
  //
  //}



  final Map<String, String> _autentDados = {
    'email': '',
    'senha': '',
  };

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            
            margin: EdgeInsets.all(20),
            child: TextFormField(
              cursorColor: Colors.black,  
              controller: _controllerEmail,
              keyboardType: TextInputType.emailAddress,
              onSaved: (email) => _autentDados['email'] =  email ?? '',
              validator: (_email) {
                final email = _email ?? '';
                if(email.trim().isEmpty || !email.contains('@')) {
                  return 'Imforme um e-mail válido';
                }
                return null;
              },
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                labelText: 'Email' ,
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                //hintText: 'exemplo@gmail.com',
                prefixIcon: Padding(
                  child: Icon(Icons.email,color: Colors.black),
                  padding: EdgeInsets.all(5),

                ),
              ),
            ),
          ),
          //const SizedBox(
          //  height: 30,
          //),
          Container(
            margin: EdgeInsets.all(20),
            child: TextFormField(
              obscureText: true,
              cursorColor: Colors.black,  
              controller: _controllerSenha,
              onSaved: (senha) => _autentDados['senha'] = senha ?? '',
              validator: (_senha) {
                final password = _senha ?? '';
                  if (password.isEmpty || password.length < 6) {
                    return 'Sua Senha deve ter no minimo 6 caracteres';
                  }
              },
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                labelText: 'Senha',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),  
                 prefixIcon: Padding(
                  child: Icon(Icons.key, color: Colors.black),
                  padding: EdgeInsets.all(5),
                ),
              ),
            ),
          ),
          if(isLogin == false)
          Container(
            margin: EdgeInsets.all(20),
            child: TextFormField(
              obscureText: true,
              cursorColor: Colors.black,  
              controller: _controllerSenha,
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                labelText: 'Confirmar Senha',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),  
                 prefixIcon: Padding(
                  child: Icon(Icons.key, color: Colors.black),
                  padding: EdgeInsets.all(5),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => setFormAction(isLogin = false), 
                  child: 
                  Text(
                    toggleButton,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
      
                const Padding(padding: EdgeInsets.symmetric(horizontal: 30)),
                
                TextButton(
                  onPressed: () {
                    if(formKey.currentState!.validate()){
                      if(isLogin){
                        login();
                      } else {
                        registrar();
                      }
                    }
                  },
                  child:  Text(
                    actionButton,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
