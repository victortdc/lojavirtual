import 'package:flutter/material.dart';
import 'package:lojavirtual/errors/EmailInvalidoException.dart';
import 'package:lojavirtual/errors/SenhaInvalidaException.dart';
import 'package:lojavirtual/models/Usuario.dart';
import 'package:lojavirtual/views/widgets/BotaoCustomizado.dart';
import 'package:lojavirtual/views/widgets/InputCustomizado.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerEmail = TextEditingController(text: "");
  TextEditingController _controllerSenha = TextEditingController(text: "");

  bool _cadastrar = false;
  String _mensagemErro = "";
  String _textoBotao = "Entrar";

  _cadastrarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .createUserWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then(
      (firebaseUser) {
        //redireciona para tela principal
        Navigator.pushReplacementNamed(context, "/");
      },
    ).catchError((e) =>
            throw (e)); //no final do metodo de comunicação do Firebase eu uso um método que pega o erro e lança excessão
  }

  _logarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .signInWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then(
      (firebaseUser) {
        //redireciona para tela principal
        Navigator.pushReplacementNamed(context, "/");
      },
    ).catchError((e) =>
            throw (e)); //no final do metodo de comunicação do Firebase eu uso um método que pega o erro e lança excessão
  }

  _validarCampos() {
    //Recupera dados dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty && senha.length > 6) {
        //Configura usuario
        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        //cadastrar ou logar
        if (_cadastrar) {
          //Cadastrar
          _cadastrarUsuario(usuario);
        } else {
          //Logar
          try {
            _logarUsuario(usuario);
          } catch (error) {
            setState(() {
              _mensagemErro = "problema ao logar usuário";
            });
          }
        }
      } else {
        setState(() {
          _mensagemErro = SenhaInvalidaException(
                  "Preencha a senha! digite mais de 6 caracteres")
              .mensagem;
          //esses erros não darão excessão e sim mostrar o Texto com a mensagem na tela
        });
      }
    } else {
      setState(() {
        _mensagemErro = EmailInvalidoException("E-mail inválido").mensagem;
        //esses erros não darão excessão e sim mostrar o Texto com a mensagem na tela
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mercado Liberal"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    "images/lojaVirtual.png",
                    width: 200,
                    height: 150,
                  ),
                ),
                InputCustomizado(
                  controller: _controllerEmail,
                  hint: "E-mail",
                  autofocus: true,
                  type: TextInputType.emailAddress,
                ),
                InputCustomizado(
                    controller: _controllerSenha, hint: "Senha", obscure: true),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Logar"),
                    Switch(
                      value: _cadastrar,
                      onChanged: (bool valor) {
                        setState(() {
                          _cadastrar = valor;
                          _textoBotao = "Entrar";
                          if (_cadastrar) {
                            _textoBotao = "Cadastrar";
                          }
                        });
                      },
                    ),
                    Text("Cadastrar"),
                  ],
                ),
                BotaoCustomizado(
                  texto: _textoBotao,
                  onPressed: () {
                    _validarCampos();
                  },
                ),
                FlatButton(
                  child: Text("Ir para anúncios"),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/");
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    _mensagemErro,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
