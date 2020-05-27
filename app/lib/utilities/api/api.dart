import 'dart:convert';
import 'package:http/http.dart' as http;

//const baseUrl = 'https://app-db-e1e6c.firebaseio.com/';

Future<Temp> fetchPost() async {
  final response = await http.get('https://app-db-e1e6c.firebaseio.com/temperature.json');
  if (response.statusCode == 200) {
    return Temp.fromJson(json.decode(response.body));
  }
  else {
    throw Exception("Something went wrong and we couldn't check the temperature :(");
  }
}

class Temp {
  final int temperature;

  Temp({this.temperature});
  factory Temp.fromJson(Map<String, dynamic> json) {
    return Temp(

      temperature: json['-M7KMn3nMQgbCRrMVbSx'],

    );
  }

}

/*void getTemperature() { 
  const temp_url = baseUrl + 'temperature.json';
  http.get(temp_url).then((res) { //pede os dados pela web

    Map<String, dynamic> tempAsMap = json.decode(res.body) as Map<String, dynamic>; //decodificando o json
    List tempsAsList = List(); //transformando em lista. acho que tem um jeito melhor que esse

    tempAsMap.forEach((k, v) => tempsAsList.add([v])); //adicionando as temperaturas do map na lista

    dynamic lastTemp = tempsAsList[(tempsAsList.length)-1]; //pegando só a última temperatura. acredito que ainda tenha um jeito

    print(lastTemp);

  });

}*/
