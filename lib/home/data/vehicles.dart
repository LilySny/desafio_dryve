

import 'package:desafio_dryve/home/interfaces/http_client.dart';
import 'package:desafio_dryve/home/interfaces/vehicles_repository.dart';
import 'package:desafio_dryve/home/models/brand.dart';
import 'package:desafio_dryve/home/models/color.dart';
import 'package:desafio_dryve/home/models/vehicle.dart';

class VehiclesRepository implements IVehiclesRepository {
  static const String kVehiclesPathUrl = "/e2fe4deb-f65d-45e2-b548-39c17f08e637";
  static const String kColorsPathUrl = "/ac466e17-58a4-432b-8647-7a2e4c4074e2";
  static const String kBrandsPathUrl = "/4f858a89-17b2-4e9c-82e0-5cdce6e90d29";
  
  VehiclesRepository({this.client});

  IClientHttp client;

  Future<List<Vehicle>> getVehicles() async {
    List<Vehicle> vehicles = [];

    final res = await client.find(kVehiclesPathUrl);

    for (Map<String, dynamic> vehicle in res) {
      Vehicle vehicleModel = Vehicle.fromJson(vehicle);

      vehicles.add(vehicleModel);
    }

    return vehicles;
  }

  Future<List<ColorModel>> getVehiclesColors() async {
    List<ColorModel> colors = [];

    final res = await client.find(kColorsPathUrl);

    for (Map<String, dynamic> color in res) {
      ColorModel colorModel = ColorModel.fromJson(color);

      colors.add(colorModel);
    }

    return colors;
  }

  Future<List<Brand>> getVehiclesBrands() async {
    List<Brand> brands = [];

    final res = await client.find(kBrandsPathUrl);

    for (Map<String, dynamic> brand in res) {
      Brand brandModel = Brand.fromJson(brand);

      brands.add(brandModel);
    }

    return brands;
  }
}
