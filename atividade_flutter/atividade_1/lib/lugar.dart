class Lugar {
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;
  final String ddd;

  Lugar({this.cep = "",
        this.logradouro = "",
        this.complemento = "",
        this.bairro = "",
        this.localidade = "",
        this.uf = "",
        this.ddd = ""});

  Lugar.fromJson(Map<String, dynamic> json)
    : cep = json["cep"],
      logradouro = json["logradouro"],
      complemento = json["complemento"],
      bairro = json["bairro"],
      localidade = json["localidade"],
      uf = json["uf"],
      ddd = json["ddd"];
}