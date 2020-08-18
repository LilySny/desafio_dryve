import 'dart:async';
import 'dart:convert';
import 'package:desafio_dryve/home/interfaces/vehicle_dao.dart';
import 'package:desafio_dryve/home/models/vehicle.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

class HiveVehicleDao implements VehicleDao {
  final _boxCompleter = Completer<Box>();
  static const String _BOXKEY = "vehicle";

  HiveVehicleDao() {
    _boxCompleter.complete(Hive.openBox(_BOXKEY));
  }

  List<Vehicle> _map(dynamic value) {
    if(value == null){
      return null;
    }
    final items = jsonDecode(value) as List;
    return items.map((e) => Vehicle.fromJson(e)).toList();
  }

  @override
  Future<void> delete(Vehicle vehicle) async {
    final box = await _boxCompleter.future;
    final items = await findAll();
    if (items != null) {
      items.remove(vehicle);
      await box.put(_BOXKEY, jsonEncode(items));
    }
  }

  @override
  Future<List<Vehicle>> findAll() async {
    final box = await _boxCompleter.future;
    final data = box.get(_BOXKEY);
    if (data != null) {
      final decoded = jsonDecode(data) as List;
      return decoded?.map((e) => Vehicle.fromJson(e))?.toList();
    }
    return null;
  }

  @override
  Stream<List<Vehicle>> findAllAsStream() {
    return _boxCompleter.future
        .asStream()
        .switchMap((box) => box
            .watch(key: _BOXKEY)
            .where((event) => !event.deleted)
            .map((event) => event.value == null ? null : _map(event.value))
            .startWith(_map(box.get(_BOXKEY))))
        .shareValue();
  }

  @override
  Future<void> saveAll(List<Vehicle> vehicles) async {
    final box = await _boxCompleter.future;
    await box.put(_BOXKEY, jsonEncode(vehicles));
  }

  @override
  Future<void> update(Vehicle vehicle) async {
    final box = await _boxCompleter.future;
    final items = await findAll();
    if (items != null) {
      final index = items.indexOf(vehicle);
      items[index] = vehicle;
      await box.put(_BOXKEY, jsonEncode(items));
    }
  }
}
