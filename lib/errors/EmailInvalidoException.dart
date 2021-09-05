import 'package:flutter/foundation.dart';

class EmailInvalidoException {
  final String mensagem;

  EmailInvalidoException(this.mensagem);

  @override
  String toString() => mensagem;
}
