import 'package:questao10/lugar.dart';
import 'package:questao10/lugarRepository.dart';
import 'package:questao10/lugarResponse.dart';
import 'package:rxdart/rxdart.dart';

class LugarBloc {
  final LugarRepository _repository = LugarRepository();
  final BehaviorSubject<bool> _loadingSubject = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<LugarResponse> _lugarResponseSubject = BehaviorSubject<LugarResponse>();
  BehaviorSubject<bool> get loadingSubject => _loadingSubject;
  BehaviorSubject<LugarResponse> get lugarResponseSubject => _lugarResponseSubject;

  getLugar(String cep) async {
    var loadingSink = _loadingSubject.sink;
    var lugarResponseSink = _lugarResponseSubject.sink;
    var isAlreadyLoading = _loadingSubject.value;
    if(isAlreadyLoading) {
      return;
    }
    loadingSink.add(true);
    if (cep.isEmpty) {
      lugarResponseSink.add(LugarResponse.withError("CEP não informado!"));
    } else {
      LugarResponse response = await _repository.getLugar(cep);
      lugarResponseSink.add(response);
    }
    loadingSink.add(false);
  }

  dispose() {
    _lugarResponseSubject.close();
    _loadingSubject.close();
  }
}