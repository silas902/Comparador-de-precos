import 'package:flutter/material.dart';

class FormularioAutenticacao extends StatefulWidget {
  const FormularioAutenticacao();

  @override
  State<FormularioAutenticacao> createState() => _FormularioAutenticacaoState();
}

class _FormularioAutenticacaoState extends State<FormularioAutenticacao> {
  late final TextEditingController _controllerEmail;
  late final TextEditingController _controllerSenha;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerEmail = TextEditingController();
    _controllerSenha = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Container(
            
            margin: EdgeInsets.all(20),
            child: TextFormField(
              cursorColor: Colors.black,  
              controller: _controllerEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
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
              cursorColor: Colors.black,  
              controller: _controllerEmail,
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
        ],
      ),
    );
  }
}
