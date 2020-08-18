import 'dart:async';
import 'dart:convert';
import 'package:desafio_dryve/home/interfaces/favorite_dao.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

class HiveFavoriteDao implements FavoriteDao {
  final _boxCompleter = Completer<Box>();
  static const String _BOXKEY = "favorites";

  HiveFavoriteDao() {
    _boxCompleter.complete(Hive.openBox(_BOXKEY));
  }

  @override
  Future<List<int>> findAll() async {
    final box = await _boxCompleter.future;
    final data = box.get(_BOXKEY);
    if (data != null) {
      return List.from(jsonDecode(data));
    }
    return null;
  }

  @override
  Stream<List<int>> findAllAsStream() {
    return _boxCompleter.future
        .asStream()
        .switchMap((box) => box
            .watch(key: _BOXKEY)
            .where((event) => !event.deleted)
            .map((event) => event.value == null
                ? null
                : List<int>.from(jsonDecode(event.value)))
            .startWith( List<int>.from(jsonDecode(box.get(_BOXKEY)))))
        .shareValue();
  }

  @override
  Future<void> saveAll(Iterable<int> vehicles) async {
    final box = await _boxCompleter.future;
    await box.put(_BOXKEY, jsonEncode(vehicles));
  }
}
