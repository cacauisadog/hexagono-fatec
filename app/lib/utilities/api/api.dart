import 'package:http/http.dart' as http;

const baseUrl = 'https://app-db-e1e6c.firebaseio.com/';

void getTemperature() {
  const temp_url = baseUrl + 'temperature.json';
  http.get(temp_url).then((res) {
    print(res);
  });
}
