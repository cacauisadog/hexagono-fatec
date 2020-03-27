import 'package:flutter/material.dart';

//Variável que guarda o estilo das "explicações" dos inputs
final kHintTextStyle=TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

//Variável que guarda o estilo do texto das labels acima dos inputs
final kLabelStyle=TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

//Variável que guarda o estilo dos inputs
final kBoxDecorationStyle=BoxDecoration(
  color: Color(0xFF212121),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);