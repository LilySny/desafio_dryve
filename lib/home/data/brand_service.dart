import 'package:desafio_dryve/home/interfaces/brand_repository.dart';
import 'package:desafio_dryve/home/interfaces/http_client.dart';
import '../models/brand.dart';

class RestBrandRepository implements BrandRepository {
  static const String kBrandsPathUrl = "/4f858a89-17b2-4e9c-82e0-5cdce6e90d29";

  RestBrandRepository({this.client});

  IClientHttp client;

  Future<List<Brand>> findAll() async {
    final res = await client.find(kBrandsPathUrl);
    final brands = (res as List).map((e) => Brand.fromJson(e)).toList();
    return brands;
  }
}
