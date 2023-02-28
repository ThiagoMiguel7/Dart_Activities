// importing dart:io file
import 'dart:io';

void main() {
  //Exercicio 1
  int numero;

  do {
    print("Entre com um número de 0 a 9999");
    String? input = stdin.readLineSync();
    numero = int.parse(input!);
  } while (numero < 0 || numero > 9999);

  dynamic unidades = numero % 10;
  dynamic numero_1 = (numero / 10);
  dynamic dezenas = numero_1 % 10;
  dynamic numero_2 = (numero_1 / 10);
  dynamic centena = numero_2 % 10;
  dynamic numero_3 = (numero_2 / 10);
  dynamic milhar = numero_3 % 10;

  int milhar_floor = milhar.floor();
  int centena_floor = centena.floor();
  int dezenas_floor = dezenas.floor();
  int unidades_floor = unidades.floor();

  print("Unidade: $unidades_floor");
  print("Dezena: $dezenas_floor");
  print("Centena: $centena_floor");
  print("Unidade de milhar: $milhar_floor\n");

  //Exercicio 2
  print("Entre com um nome completo de uma pessoa: ");
  String? nome = stdin.readLineSync();

  print(nome?.toUpperCase());
  print(nome?.toLowerCase());
  print(nome?.replaceAll(" ", "").length);

  var tmp = nome?.split(" ");
  dynamic primeiroNome = tmp?[0];
  print(primeiroNome);
  print("\n");

  //Exercicio 3
  var numeroTemp;
  dynamic farenheit;
  dynamic celcius;

  do {
    print("Entre com uma temperatura. Digite 1-Celsius ou 2-Farenheit");
    String? inputTemp = stdin.readLineSync();
    numeroTemp = int.parse(inputTemp!);
  } while (numeroTemp >= 3 || numeroTemp <= 0);

  switch (numeroTemp) {
    case 1:
      print("Entre com a temperatura em Celsius.");
      String? inputCelcius = stdin.readLineSync();
      celcius = double.parse(inputCelcius!);

      farenheit = ((celcius) * 9 / 5 + 32);
      print("A Temperatura em Farenheit é $farenheitºF.");
      break;

    case 2:
      print("Entre com a temperatura em Farenheit.");
      String? inputFarenheit = stdin.readLineSync();
      farenheit = double.parse(inputFarenheit!);

      celcius = ((farenheit - 32) * 5 / 9);
      print("A Temperatura em Celcius é $celciusºC.");
      break;
  }

  //Exercicio 6
  var reta_1;
  var reta_2;
  var reta_3;

  print("\nEntre com a medida do lado A do triangulo: ");
  String? A = stdin.readLineSync();
  reta_1 = int.parse(A!);

  print("Entre com a medida do lado B do triangulo: ");
  String? B = stdin.readLineSync();
  reta_2 = int.parse(B!);

  print("Entre com a medida do lado C do triangulo: ");
  String? C = stdin.readLineSync();
  reta_3 = int.parse(C!);

  if (reta_1 <= 0 || reta_2 <= 0 || reta_3 <= 0) {
    print("Lados nulos ou negativos não são aceitos.");
    exit(1);
  } else if (reta_1 >= reta_2 + reta_3 ||
      reta_2 >= reta_3 + reta_1 ||
      reta_3 >= reta_1 + reta_2) {
    print("Essas retas não podem formar um triângulo");
    exit(1);
  } else {
    print("Essas retas podem o formar um triângulo");
  }
}
