import 'package:dio/dio.dart';
import 'package:questao10/lugarResponse.dart';
import 'package:questao10/lugar.dart';

class LugarApiProvider {
  final String _endpoint = "https://viacep.com.br/ws/";
  final Dio _dio = Dio();

  Future<LugarResponse> getLugar(String cep) async {
    try {
      Response response = await _dio.get("$_endpoint$cep/json/");
      return LugarResponse.withSuccess(Lugar.fromJson(response.data));
    } catch (error, stacktrace) {
      return LugarResponse.withError("$error");
    }
  }
}