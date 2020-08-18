// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStoreBase, Store {
  Computed<bool> _$isDisconnectedComputed;

  @override
  bool get isDisconnected =>
      (_$isDisconnectedComputed ??= Computed<bool>(() => super.isDisconnected,
              name: '_HomeStoreBase.isDisconnected'))
          .value;
  Computed<bool> _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_HomeStoreBase.isLoading'))
          .value;

  final _$_connectionStatusAtom =
      Atom(name: '_HomeStoreBase._connectionStatus');

  @override
  ObservableStream<DataConnectionStatus> get _connectionStatus {
    _$_connectionStatusAtom.reportRead();
    return super._connectionStatus;
  }

  @override
  set _connectionStatus(ObservableStream<DataConnectionStatus> value) {
    _$_connectionStatusAtom.reportWrite(value, super._connectionStatus, () {
      super._connectionStatus = value;
    });
  }

  final _$_vehiclesAtom = Atom(name: '_HomeStoreBase._vehicles');

  @override
  ObservableStream<List<Vehicle>> get _vehicles {
    _$_vehiclesAtom.reportRead();
    return super._vehicles;
  }

  @override
  set _vehicles(ObservableStream<List<Vehicle>> value) {
    _$_vehiclesAtom.reportWrite(value, super._vehicles, () {
      super._vehicles = value;
    });
  }

  final _$_HomeStoreBaseActionController =
      ActionController(name: '_HomeStoreBase');

  @override
  void startStreaming() {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.startStreaming');
    try {
      return super.startStreaming();
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filter(FilterParams filter) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.filter');
    try {
      return super.filter(filter);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDisconnected: ${isDisconnected},
isLoading: ${isLoading}
    ''';
  }
}
