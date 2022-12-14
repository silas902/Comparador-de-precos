import 'package:comparador_de_precos/exceptions/auth_exception.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/authentication_provider.dart';

class AuthenticationForm extends StatefulWidget {
  const AuthenticationForm({Key? key, required this.authenticationProvider}) : super(key: key);
  final AuthenticationProvider authenticationProvider;
  @override
  State<AuthenticationForm> createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  late final TextEditingController _controllerEmail;
  late final TextEditingController _controllerPassword;
  late final TextEditingController _controllerPasswordConfirm;
  bool _showPassword = false;
  final formKey = GlobalKey<FormState>();

  late bool isLogin;
  late String actionButton;
  late String toggleButton;

  @override
  void initState() {
    if (mounted) {
      setState(() {});
      super.initState();
    }
    setFormAction(isLogin = true);

    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
    _controllerPasswordConfirm = TextEditingController();
  }

  setFormAction(isLogin) {
    if (mounted) {
      setState(() {
        //isLogin = acao;
        if (isLogin) {
          actionButton = 'Login';
          toggleButton = 'Cadastre-se';
        } else {
          actionButton = 'Cadastrar';
          toggleButton = 'Voltar ao Login';
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerPasswordConfirm.dispose();
  }

  void _showErrorDialo(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ocorreu um erro'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          )
        ],
      ),
    );
  }

  Future<void> login() async {
    //try {
      if (isLogin) {
        await widget.authenticationProvider.login(_controllerEmail.text, _controllerPassword.text);
      } else {
        widget.authenticationProvider.signup(_controllerEmail.text, _controllerPassword.text);
      }
   // } on AuthException catch (error) {
   //   _showErrorDialo(error.toString());
   // } catch (error) {
    //  _showErrorDialo('Ocorreu um errro inesperado!');
   // }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: TextFormField(
              cursorColor: Colors.black,
              controller: _controllerEmail,
              keyboardType: TextInputType.emailAddress,
              //onSaved: (email) => _autentDados['email'] = email ?? '',
              validator: (_email) {
                final email = _email ?? '';
                if (email.trim().isEmpty || !email.contains('@')) {
                  return 'Imforme um e-mail v??lido';
                }
                return null;
              },
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Padding(
                  child: Icon(Icons.email, color: Colors.black),
                  padding: EdgeInsets.all(5),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextFormField(
              obscureText: _showPassword == false ? true : false,
              cursorColor: Colors.black,
              controller: _controllerPassword,
              //onSaved: (senha) => _autentDados['senha'] = senha ?? '',
              validator: (_senha) {
                final password = _senha ?? '';
                if (password.isEmpty || password.length < 6) {
                  return 'Sua Senha deve ter no minimo 6 caracteres';
                }
                return null;
              },
              decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                labelText: 'Senha',
                labelStyle: const TextStyle(color: Colors.black),
                prefixIcon: const Padding(
                  child: Icon(Icons.key, color: Colors.black),
                  padding: EdgeInsets.all(5),
                ),
                suffixIcon: GestureDetector(
                  child: Icon(
                    _showPassword == false
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.black,
                  ),
                  onTap: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                ),
              ),
            ),
          ),
          if (isLogin == false)
            Container(
              margin: const EdgeInsets.all(20),
              child: TextFormField(
                obscureText: _showPassword == false ? true : false,
                cursorColor: Colors.black,
                validator: (_password) {
                  final password = _password ?? '';
                  if (password == _controllerPassword.text) {
                    return null;
                  }
                  return 'Senhas n??o conferem.';
                },
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: 'Confirmar Senha',
                  labelStyle: TextStyle(color: Colors.black),
                  prefixIcon: Padding(
                    child: Icon(Icons.key, color: Colors.black),
                    padding: EdgeInsets.all(5),
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(
              top: 25,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () =>
                      setFormAction(isLogin ? isLogin = false : isLogin = true),
                  child: Text(
                    toggleButton,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 30)),
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      login();
                    }
                  },
                  child: Text(
                    actionButton,
                    style: const TextStyle(color: Colors.black),
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
