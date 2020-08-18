import 'package:desafio_dryve/home/interfaces/brand_dao.dart';
import 'package:desafio_dryve/home/models/brand.dart';
import 'package:mobx/mobx.dart';
import 'package:desafio_dryve/shared/utils/string_filter_utils.dart';
part 'mark_store.g.dart';

class MarkStore = _MarkStoreBase with _$MarkStore;

abstract class _MarkStoreBase with Store {
  final BrandDao _brandDao;

  _MarkStoreBase(this._brandDao) {
    startStreaming();
  }

  @observable
  String _searchTerm = "";

  String get searchTerm => _searchTerm;

  set searchTerm(String term) => _searchTerm = term;

  @observable
  ObservableStream<List<Brand>> _brands;
  ObservableStream<List<Brand>> get brands => _brands;

  @action
  void filter() {
    print(_brands.value);
    _brands = _brands.map((event) => event
        .where((element) => element.name.containsAny(_searchTerm))
        .toList());
    print(_brands.value);
  }

  @action
  void startStreaming() {
    _brands = _brandDao.findAllAsStream().asObservable();
  }
}
