import 'package:desafio_dryve/home/interfaces/color_dao.dart';
import 'package:desafio_dryve/home/models/brand.dart';
import 'package:desafio_dryve/home/models/color.dart';
import 'package:desafio_dryve/home/models/filter_params.dart';
import 'package:mobx/mobx.dart';
part 'filter_store.g.dart';

class FilterStore = _FilterStoreBase with _$FilterStore;

abstract class _FilterStoreBase with Store {
  final ColorDao _colorDao;

  @observable
  FilterParams _filter;

  _FilterStoreBase(this._colorDao);

  FilterParams get filter => _filter;

  @observable
  ObservableStream<List<ColorModel>> _colors;
  ObservableStream<List<ColorModel>> get colors => _colors;
  
  @observable
  ObservableList<int> _filterBrands = ObservableList<int>();
  ObservableList<int> get filterBrands => _filterBrands;

  @observable
  ObservableList<int> _filterColors = ObservableList<int>();
  ObservableList<int> get filterColors => _filterColors;

  @action
  void clearFilter() {
    _filterBrands.clear();
    _filterColors.clear();
  }

  @action
  void applyFilter() {
    _filter = FilterParams(_filterColors, _filterBrands);
  }

  @action
  void startStreaming() {
    _colors = _colorDao.findAllAsStream().asObservable();
  }
}
