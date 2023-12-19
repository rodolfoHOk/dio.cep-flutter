import 'package:cep_flutter/exceptions/bad_request_exception.dart';
import 'package:cep_flutter/exceptions/http_request_exception.dart';
import 'package:cep_flutter/models/via_cep_model.dart';
import 'package:cep_flutter/services/viacep/via_cep_dio.dart';
import 'package:dio/dio.dart';

class ViaCEPService {
  late ViaCEPDio _viaCEPDio;

  ViaCEPService() {
    _viaCEPDio = ViaCEPDio();
  }

  Future<ViaCEPModel> getByCEP(String cep) async {
    Response<dynamic>? response;
    try {
      response = await _viaCEPDio.dio.get("/$cep/json");
      return ViaCEPModel.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 400) {
          throw BadRequestException(
              "Erro ao tentar buscar CEP: 400 Baq Request");
        }
        throw HttpRequestException(
            "Erro ao tentar buscar CEP: status code ${e.response!.statusCode.toString()}");
      }
      rethrow;
    }
  }
}
