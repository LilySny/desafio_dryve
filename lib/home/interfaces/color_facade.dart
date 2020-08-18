
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:desafio_dryve/home/data/color_service.dart';
import 'package:desafio_dryve/home/data/hive_color_dao.dart';
import 'package:desafio_dryve/home/services/color_facade_impl.dart';
import 'package:desafio_dryve/home/models/color.dart';
import 'package:desafio_dryve/home/services/http_client.dart';

abstract class ColorFacade {
  Stream<List<ColorModel>> findAllColors();

  static ColorFacade create() {
    return ColorFacadeImpl(
      RestColorRepository(
          client: ClientHttpService(
        baseUrl: "https://run.mocky.io/v3",
      )),
      HiveColorDao(),
      DataConnectionChecker(),
    );
  }
}