import 'package:app/core/internationalization/app_language.dart';
import 'package:app/screens/homepage.dart';
import 'package:app/utilities/api/sign-in.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/login.dart';
import 'package:app/core/internationalization/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

AppLanguage appLanguage = AppLanguage();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  AppLanguage appLanguage = AppLanguage();
  
  await appLanguage.fetchLocale();
  runApp(MyApp(
    appLanguage: appLanguage,
  ));
}

class MyApp extends StatelessWidget {

  final AppLanguage appLanguage;

  MyApp({this.appLanguage});

  @override
  Widget build(BuildContext context) {

    OneSignal.shared.init('4e00ece4-3802-4c60-b83c-314b3d74ace2');

    return ChangeNotifierProvider<AppLanguage>(
      create: (_) => appLanguage,
      child: Consumer<AppLanguage>(builder: (context, model, child) {
        return MaterialApp(
          locale: model.appLocal,
          supportedLocales: [
            const Locale('en', 'US'),
            const Locale('pt', 'BR'),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          home: FutureBuilder( //verificação se o usuário já está logado no app p/ não ir para a tela de login
            future: signInWithGoogle(),
            builder: (context, snapshot){
              if(snapshot.hasData){
                return Homepage(); //se houver dados salvos, ela vai direto para a homepage
              }
              else {
                return LoginScreen(); //se não houver dados salvas, ela vai para o login
              }
            },
          ),
        );
      }),
    );
  }
}