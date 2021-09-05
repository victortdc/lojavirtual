import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'views/Anuncios.dart';
import 'views/DetalhesAnuncio.dart';
import 'views/Login.dart';
import 'views/MeusAnuncios.dart';
import 'views/NovoAnuncio.dart';

//Factory Method, parecido, comentário do prórpio professor
// usado pra reduzir o código que constroi componentes no framework em um método
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => Anuncios(),
        );
      case "/login":
        return MaterialPageRoute(
          builder: (_) => Login(),
        );
      case "/meus-anuncios":
        return MaterialPageRoute(
          builder: (_) => MeusAnuncios(),
        );
      case "/novo-anuncio":
        return MaterialPageRoute(
          builder: (_) => NovoAnuncio(),
        );
      case "/detalhes-anuncio":
        return MaterialPageRoute(
          builder: (_) => DetalhesAnuncio(args),
        );
      default:
        _erroRota();
    }
  }

  //usando Padrão Builder
  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Tela não encontrada!"),
          ),
          body: Center(
            child: Text("Tela não encontrada!"),
          ),
        );
      },
    );
  }
}
