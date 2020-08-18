import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:desafio_dryve/home/interfaces/vehicle_dao.dart';
import 'package:desafio_dryve/home/models/filter_params.dart';
import 'package:desafio_dryve/home/models/vehicle.dart';
import 'package:mobx/mobx.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final VehicleDao _vehicleDao;
  final DataConnectionChecker _dataConnectionChecker;

  _HomeStoreBase(this._vehicleDao, this._dataConnectionChecker) {
    _connectionStatus = _dataConnectionChecker.onStatusChange.asObservable();
  }

  @observable
  ObservableStream<DataConnectionStatus> _connectionStatus;

  ObservableStream<DataConnectionStatus> get connectionStatus =>
      _connectionStatus;

  @computed
  bool get isDisconnected =>
      connectionStatus.value == DataConnectionStatus.disconnected;

  @observable
  ObservableStream<List<Vehicle>> _vehicles;

  ObservableStream<List<Vehicle>> get vehicles => _vehicles;

  @computed
  bool get isLoading => _vehicles.status == StreamStatus.waiting;

  @action
  void startStreaming() {
    _vehicles = _vehicleDao.findAllAsStream().asObservable();
  }

  @action
  void filter(FilterParams filter) {
    _vehicles = _vehicles.map((event) => _doFilter(filter, event));
  }

  List<Vehicle> _doFilter(FilterParams filterParams, List<Vehicle> vehicles) {
    return vehicles.where((element) {
      final brandsFilter = filterParams.brands.isNotEmpty &&
          filterParams.brands.contains(element.brandId);

      final colorsFilter = filterParams.colors.isNotEmpty &&
          filterParams.colors.contains(element.colorId);

      if (filterParams.brands.isNotEmpty && filterParams.colors.isNotEmpty) {
        return brandsFilter && colorsFilter;
      } else {
        return brandsFilter || colorsFilter;
      }
    }).toList();
  }
}
