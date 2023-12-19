import 'package:cep_flutter/models/via_cep_model.dart';
import 'package:cep_flutter/services/viacep/via_cep_dio.dart';

class ViaCEPService {
  late ViaCEPDio _viaCEPDio;

  ViaCEPService() {
    _viaCEPDio = ViaCEPDio();
  }

  Future<ViaCEPModel> getByCEP(String cep) async {
    var response = await _viaCEPDio.dio.get("/$cep/json");
    return ViaCEPModel.fromJson(response.data);
  }
}
