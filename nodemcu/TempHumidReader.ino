#include <Wire.h>
#include <SSD1306Wire.h>
#include <DHT.h>
#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>
#include <ESP8266mDNS.h>
#include <FirebaseArduino.h>

//Dados da rede wifi
#define STASSID "STASSID" //coloca a ssid da sua net no lugar do SSID
#define STAPSK  "STAPSK" //coloca a senha no lugar do password
const char* ssid = STASSID;
const char* password = STAPSK;

//Dados do firebase
#define FIREBASE_HOST "seu FIREBASE_HOST"
#define FIREBASE_AUTH "seu FIREBASE_AUTH"

ESP8266WebServer server(80);

//Pino de ligacao do DHT11
#define DHTPIN 5

//Define o tipo de sensor DHT
#define DHTTYPE DHT11

// Inicializa o display Oled SDA 2, SCL 14
SSD1306Wire  display(0x3c, 2, 14);

int minima = 99;
int maxima = 0;
int t; //temperatura
int h; //humidade
 
DHT dht(DHTPIN, DHTTYPE);

//Intervalo de tempo entre leituras
const long intervalo = 5000;

//Armazena o valor (tempo) da ultima leitura
unsigned long previousMillis = 0;

void setup()
{
  Serial.begin(115200);

  //Inicializa o Wifi
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
  
  server.on("/", handleRoot);

  server.on("/inline", []() {
    server.send(200, "text/plain", "funcionando");
  });

  server.begin();
  Serial.println("HTTP server started");

  //Iniciar display Oled
  display.init();
  display.flipScreenVertically();

  //Iniciar sensor de temperatura
  dht.begin();

  //Iniciar Firebase
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
}

void handleRoot()
{
  server.send(200, "text/plain", "verificacao de temperatura em tempo real\n\nA temperatura atual e de " + String(t) + " graus\nA temperatura maxima foi de " + String(maxima) + " graus \ne a humidade é " + String(h) + " %");
}
void drawLines() {

  //Apaga o display
  display.clear();
  
  for (int16_t i=0; i<display.getWidth(); i+=4) {
    display.drawLine(0, 0, i, display.getHeight()-1);
    display.display();
    delay(10);
  }
  for (int16_t i=0; i<display.getHeight(); i+=4) {
    display.drawLine(0, 0, display.getWidth()-1, i);
    display.display();
    delay(10);
  }
  display.display();
  delay(250);
}
  
void Atualiza_Temperatura_Display(int temperatura, int h, int min_s)
{
  //Apaga o display
  display.clear();

  //Desenha as molduras
  display.drawRect(0, 0, 128, 16);
  display.drawRect(0, 16, 128, 48);
  display.drawLine(67, 16, 67, 63);
  display.drawLine(67, 40, 128, 40);
  display.setFont(ArialMT_Plain_10);
  display.setTextAlignment(TEXT_ALIGN_CENTER);
  

  //Atualiza informacoes da temperatura
  display.setFont(ArialMT_Plain_10);
  display.setTextAlignment(TEXT_ALIGN_CENTER);
  display.drawString(64, 2, "Hexagono Group");
  display.setFont(ArialMT_Plain_24);
  display.drawString(32, 26, String(temperatura));
  display.drawCircle(52, 32, 2);

  //Atualiza maxima e minima
  display.setTextAlignment(TEXT_ALIGN_LEFT);
  display.setFont(ArialMT_Plain_10);
  display.drawString(73, 24, "hum        %");
  display.setFont(ArialMT_Plain_16);
  display.drawString(97, 19, String(h));

  display.setFont(ArialMT_Plain_10);
  display.drawString(73, 48, "Min");
  display.setFont(ArialMT_Plain_16);
  display.drawString(97, 43, String(min_s));

  display.display();
}

void loop() {
  unsigned long currentMillis = millis();

  //Verifica se o intervalo já foi atingido
  if (currentMillis - previousMillis >= intervalo)
  {
    //Armazena o valor da ultima leitura
    previousMillis = currentMillis;

    //Le a temperatura
    t = dht.readTemperature();

    //Le a humidade
    float h = dht.readHumidity();
    
    //Receber a variavel t do firebase
    Firebase.pushFloat("temperature", t);

    //Receber a variavel h do firebase
    Firebase.pushFloat("humidity", h);
   
    //Mostra a temperatura no Serial Monitor
    Serial.print(F("Temperatura: "));
    Serial.print(t);
    Serial.println(F("°C "));

    //Atualiza a variavel maxima, se necessario
    if (t <= minima){minima = t;}

    //Envia as informacoes para o display
    Atualiza_Temperatura_Display(t, h, minima);
  }
    
    
   server.handleClient();
   MDNS.update();
}
