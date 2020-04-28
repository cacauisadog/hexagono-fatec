import 'package:app/core/internationalization/app_localizations.dart';
import 'package:flutter/cupertino.dart';

class AppTranslate {
  final BuildContext context;

  AppTranslate(this.context);

  String text(String key){
    return AppLocalizations.of(context).translate(key);
  }
}