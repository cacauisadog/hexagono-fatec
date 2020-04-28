import 'package:flutter/material.dart';
import 'package:app/main.dart';

//Botão para mudar o idioma do app

Widget selectLanguage() => Container(
  alignment: Alignment.bottomLeft,
  child: PopupMenuButton<int>(
    itemBuilder: (context) => [
      PopupMenuItem(
        value: 1,
        child: GestureDetector(
          onTap: () {
            appLanguage.changeLanguage(Locale('en'));
          },
          child: Text('English (US)'),
        ),
      ),
      PopupMenuItem(
        value: 1,
        child: GestureDetector(
          onTap: () {
            appLanguage.changeLanguage(Locale('pt'));
          },
          child: Text('Português (BR)'),
        ),
      ),
    ],
    icon: Icon(Icons.language, color: Colors.white,),
    offset: Offset(0, 100),
  ),
);