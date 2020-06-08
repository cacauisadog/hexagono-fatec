import 'package:app/screens/sidebar/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:app/utilities/api/api.dart' as api;

class HomepageBody extends StatelessWidget {
  //aqui é o corpo da home page

  final Future temp;

  const HomepageBody({Key key, this.temp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //a caixinha que guarda todas as coisas da homepage
      height: double.infinity,
      width: double.infinity,

      decoration: BoxDecoration(
          //gradiente do fundo da página

          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xDD000000),
          Color(0xFF000000),
          Color(0xFF000000),
        ],
        stops: [0.1, 0.7, 0.9],
      )),

      child: Container(
        //um outro container pras coisas não ficarem desconectadas e assimétricas

        height: double.infinity,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 68,
          ),
          child: Column(
              //uma coluna no centro pra alinhar as coisas
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  //o texto 'home page!'. isso pode sair em breve
                  child: Text(
                    'Home page!',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  //esse é o container da caixa da temperatura

                  child: Column(
                      //coluninha pra alinhar no centro né :)
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            //esse daqui é o retângulo de bordas arredondadas
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.all(10.0),
                            width: 800.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                                //isso daqui faz ter cor de fundo e arredondar as bordas
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(20.0),
                                  topRight: const Radius.circular(20.0),
                                  bottomLeft: const Radius.circular(20.0),
                                  bottomRight: const Radius.circular(20.0),
                                )),
                            child: FutureBuilder(
                                future: api.getLastTemperature(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    //se conseguiu achar dados para exibir
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        //o texto da temperatura, que pode ser escrito com outro design pra ficar muito mais bonito
                                        'Temperature:\n' +
                                            snapshot.data
                                                .toString()+'ºC', //como agora tô passando diretamente o valor da temperatura, apenas o converto direto pra String
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'OpenSans',
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  }
                                  return Center(child: CircularProgressIndicator());
                                }))
                      ]),
                ),
                Container(
                    //esse daqui é o retângulo de bordas arredondadas (de novo)
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.all(10.0),
                    width: 800.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                        //isso daqui faz ter cor de fundo e arredondar as bordas
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20.0),
                          topRight: const Radius.circular(20.0),
                          bottomLeft: const Radius.circular(20.0),
                          bottomRight: const Radius.circular(20.0),
                        )),
                    child: FutureBuilder(
                        future: api.getLastHumidity(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            //se conseguiu achar dados para exibir
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                //o texto da umidade, que pode ser escrito com outro design pra ficar muito mais bonito
                                'Humidity:\n' + snapshot.data.toString()+'%', //como agora tô passando diretamente o valor da umidade, apenas o converto direto pra String
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'OpenSans',
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return Center(child: CircularProgressIndicator());
                        }))
              ]),
        ),
      ),
    );
  }
}

//aqui embaixo tem duas classes: a homepageBody() e a Sidebar(). tive que fazer isso porque
//senão o sidebar não iria sobrepor a página
class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //o scaffold faz o app deixar a barra de notificação da cor do app (foi a diferença que mais notei)

      body: Stack(children: <Widget>[
        //o stack possibilita ter camadas. no nosso caso uma pro homepageBody e outra pro menu (sobreposição)
        HomepageBody(), //o que é chamado primeiro fica embaixo
        Sidebar(), //o que é chamado depois fica por cima
      ]),
    );
  }
}
