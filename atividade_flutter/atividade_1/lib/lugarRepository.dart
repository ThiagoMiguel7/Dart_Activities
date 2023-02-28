import 'package:questao10/lugarApiProvider.dart';
import 'package:questao10/lugarResponse.dart';

class LugarRepository {
  final LugarApiProvider _apiProvider = LugarApiProvider();

  Future<LugarResponse> getLugar(String cep) {
    return _apiProvider.getLugar(cep);
  }
}