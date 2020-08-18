import 'package:desafio_dryve/home/interfaces/http_client.dart';
import 'package:desafio_dryve/home/interfaces/vehicle_repository.dart';
import 'package:desafio_dryve/home/models/vehicle.dart';


class RestVehicleRepository implements VehicleRepository {
  static const String kVehiclesPathUrl =
      "/e2fe4deb-f65d-45e2-b548-39c17f08e637";
  RestVehicleRepository({this.client});

  IClientHttp client;

  Future<List<Vehicle>> findAll() async {
    final res = await client.find(kVehiclesPathUrl);
    final vehicles = (res as List).map((e) => Vehicle.fromJson(e)).toList();
    return vehicles;
  }
}
