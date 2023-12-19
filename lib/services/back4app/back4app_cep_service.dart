import 'package:cep_flutter/exceptions/bad_request_exception.dart';
import 'package:cep_flutter/exceptions/http_request_exception.dart';
import 'package:cep_flutter/models/cep_model.dart';
import 'package:cep_flutter/models/via_cep_model.dart';
import 'package:cep_flutter/services/back4app/back4app_dio.dart';
import 'package:dio/dio.dart';

class Back4AppCEPService {
  late Back4AppDio _back4appDio;

  Back4AppCEPService() {
    _back4appDio = Back4AppDio();
  }

  Future<void> create(ViaCEPModel viaCEPModel) async {
    try {
      var cepModel = CEPModel.fromJson(viaCEPModel.toJson());
      await _back4appDio.dio.post("/CEP", data: cepModel.toJson());
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 400) {
          throw BadRequestException(
              "Erro ao tentar cadastrar CEP: 400 Bad Request");
        }
        throw HttpRequestException(
            "Erro ao tentar cadastrar CEP: status code ${e.response!.statusCode.toString()}");
      }
      rethrow;
    }
  }

  Future<List<CEPModel>> list() async {
    try {
      var response = await _back4appDio.dio.get("/CEP");
      return (response.data as List)
          .map((cep) => CEPModel.fromJson(cep))
          .toList();
    } catch (e) {
      if (e is DioException) {
        throw HttpRequestException(
            "Erro ao tentar listar CEPs: status code ${e.response!.statusCode.toString()}");
      }
      rethrow;
    }
  }

  Future<CEPModel> getByObjectId(String objectId) async {
    try {
      var response = await _back4appDio.dio.get("/CEP/$objectId");
      return CEPModel.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 404) {
          throw BadRequestException(
              "Erro ao tentar buscar CEP: 404 CEP não encontrado");
        }
        throw HttpRequestException(
            "Erro ao tentar buscar CEP: status code ${e.response!.statusCode.toString()}");
      }
      rethrow;
    }
  }

  Future<void> update(String objectId, ViaCEPModel viaCEPModel) async {
    try {
      var cepModel = CEPModel.fromJson(viaCEPModel.toJson());
      await _back4appDio.dio.put("/CEP/$objectId", data: cepModel.toJson());
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 400) {
          throw BadRequestException(
              "Erro ao tentar atualizar CEP: 400 Baq Request");
        }
        throw HttpRequestException(
            "Erro ao tentar atualizar CEP: status code ${e.response!.statusCode.toString()}");
      }
      rethrow;
    }
  }

  Future<void> delete(String objectId) async {
    try {
      await _back4appDio.dio.delete("/CEP/$objectId");
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 400) {
          throw BadRequestException(
              "Erro ao tentar deletar CEP: 400 Baq Request");
        }
        if (e.response!.statusCode == 404) {
          throw BadRequestException(
              "Erro ao tentar deletar CEP: 404 CEP não encontrado");
        }
        throw HttpRequestException(
            "Erro ao tentar deletar CEP: status code ${e.response!.statusCode.toString()}");
      }
      rethrow;
    }
  }
}
