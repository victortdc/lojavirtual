import 'package:flutter/material.dart';

import 'RouteGenerator.dart';
import 'views/Anuncios.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: Color(0xff9c27b0),
  accentColor: Color(0xff7b1fa2),
);

void main() => runApp(
      MaterialApp(
        title: "Loja Virtual",
        home: Anuncios(),
        theme: temaPadrao,
        initialRoute: "/",
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
