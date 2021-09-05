import 'package:flutter/foundation.dart';

class SenhaInvalidaException {
  final String mensagem;

  SenhaInvalidaException(this.mensagem);

  @override
  String toString() => mensagem;
}
