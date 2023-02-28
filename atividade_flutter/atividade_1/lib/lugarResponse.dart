import 'package:questao10/lugar.dart';

class LugarResponse {
  final Lugar lugar;
  final String error;

  LugarResponse(this.lugar, this.error);

  LugarResponse.withSuccess(Lugar lugar)
  : this.lugar = lugar,
    error = "";

  LugarResponse.withError(String errorValue)
  : lugar = Lugar(),
    error = errorValue;
}