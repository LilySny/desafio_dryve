
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:desafio_dryve/home/data/brand_service.dart';
import 'package:desafio_dryve/home/data/hive_brand_dao.dart';
import 'package:desafio_dryve/home/services/brand_facade_impl.dart';
import 'package:desafio_dryve/home/models/brand.dart';

import 'package:desafio_dryve/home/services/http_client.dart';

abstract class BrandFacade {
  Stream<List<Brand>> findAllBrands();

  static BrandFacade create() {
    return BrandFacadeImpl(
      RestBrandRepository(
          client: ClientHttpService(
        baseUrl: "https://run.mocky.io/v3",
      )),
      HiveBrandDao(),
      DataConnectionChecker(),
    );
  }
}