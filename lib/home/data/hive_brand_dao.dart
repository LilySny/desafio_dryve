import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:desafio_dryve/home/interfaces/brand_dao.dart';
import 'package:desafio_dryve/home/models/brand.dart';
import 'package:hive/hive.dart';

class HiveBrandDao implements BrandDao {
  final _boxCompleter = Completer<Box>();
  static const String _BOXKEY = "brands";

  HiveBrandDao() {
    _boxCompleter.complete(Hive.openBox(_BOXKEY));
  }

  List<Brand> _map(dynamic value) {
        if(value == null){
      return null;
    }
    final items = jsonDecode(value) as List;
    return items.map((e) => Brand.fromJson(e)).toList();
  }

  @override
  Future<void> delete(Brand vehicle) async {
    final box = await _boxCompleter.future;
    final items = await findAll();
    if (items != null) {
      items.remove(vehicle);
      await box.put(_BOXKEY, jsonEncode(items));
    }
  }

  @override
  Future<List<Brand>> findAll() async {
    final box = await _boxCompleter.future;
    final data = box.get(_BOXKEY);
    if (data != null) {
      return _map(data);
    }
    return null;
  }

  @override
  Stream<List<Brand>> findAllAsStream() {
    return _boxCompleter.future
        .asStream()
        .switchMap((box) => box
            .watch(key: _BOXKEY)
            .where((event) => !event.deleted)
            .map((event) => event == null ? null : _map(event.value))
            .startWith(_map(box.get(_BOXKEY))))
        .shareValue();
  }

  @override
  Future<void> saveAll(List<Brand> vehicles) async {
    final box = await _boxCompleter.future;
    await box.put(_BOXKEY, jsonEncode(vehicles));
  }

  @override
  Future<void> update(Brand vehicle) async {
    final box = await _boxCompleter.future;
    final items = await findAll();
    if (items != null) {
      final index = items.indexOf(vehicle);
      items[index] = vehicle;
      await box.put(_BOXKEY, jsonEncode(items));
    }
  }
}
