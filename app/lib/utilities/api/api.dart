import 'dart:convert';

import 'package:http/http.dart' as http;

const baseUrl = 'https://app-db-e1e6c.firebaseio.com/';

void getTemperature() { 
  const temp_url = baseUrl + 'temperature.json';
  http.get(temp_url).then((res) { //pede os dados pela web

    Map<String, dynamic> tempAsMap = json.decode(res.body) as Map<String, dynamic>; //decodificando o json
    List tempsAsList = List(); //transformando em lista. acho que tem um jeito melhor que esse

    tempAsMap.forEach((k, v) => tempsAsList.add([v])); //adicionando as temperaturas do map na lista

    dynamic lastTemp = tempsAsList[(tempsAsList.length)-1]; //pegando só a última temperatura. acredito que ainda tenha um jeito

    print(lastTemp);

  });

}
