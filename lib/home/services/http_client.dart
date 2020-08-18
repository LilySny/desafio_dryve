import 'package:desafio_dryve/home/interfaces/http_client.dart';
import 'package:dio/dio.dart';

class ClientHttpService implements IClientHttp {
  Dio dio;

  ClientHttpService({String baseUrl = ""}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveTimeout: 10000,
      ),
    );
  }

  @override
  Future find(String path) async {
    Response response = await dio.get(path);

    return response.data;
  }
}
