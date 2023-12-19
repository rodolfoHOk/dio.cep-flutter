import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ViaCEPDio {
  late Dio _dio;

  ViaCEPDio() {
    _dio = Dio();
    _dio.options.baseUrl = dotenv.get("VIACEP_BASE_URL");
  }

  Dio get dio => _dio;
}
