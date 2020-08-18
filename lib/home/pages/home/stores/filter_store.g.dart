// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FilterStore on _FilterStoreBase, Store {
  final _$_filterAtom = Atom(name: '_FilterStoreBase._filter');

  @override
  FilterParams get _filter {
    _$_filterAtom.reportRead();
    return super._filter;
  }

  @override
  set _filter(FilterParams value) {
    _$_filterAtom.reportWrite(value, super._filter, () {
      super._filter = value;
    });
  }

  final _$_colorsAtom = Atom(name: '_FilterStoreBase._colors');

  @override
  ObservableStream<List<ColorModel>> get _colors {
    _$_colorsAtom.reportRead();
    return super._colors;
  }

  @override
  set _colors(ObservableStream<List<ColorModel>> value) {
    _$_colorsAtom.reportWrite(value, super._colors, () {
      super._colors = value;
    });
  }

  final _$_filterBrandsAtom = Atom(name: '_FilterStoreBase._filterBrands');

  @override
  ObservableList<int> get _filterBrands {
    _$_filterBrandsAtom.reportRead();
    return super._filterBrands;
  }

  @override
  set _filterBrands(ObservableList<int> value) {
    _$_filterBrandsAtom.reportWrite(value, super._filterBrands, () {
      super._filterBrands = value;
    });
  }

  final _$_filterColorsAtom = Atom(name: '_FilterStoreBase._filterColors');

  @override
  ObservableList<int> get _filterColors {
    _$_filterColorsAtom.reportRead();
    return super._filterColors;
  }

  @override
  set _filterColors(ObservableList<int> value) {
    _$_filterColorsAtom.reportWrite(value, super._filterColors, () {
      super._filterColors = value;
    });
  }

  final _$_FilterStoreBaseActionController =
      ActionController(name: '_FilterStoreBase');

  @override
  void clearFilter() {
    final _$actionInfo = _$_FilterStoreBaseActionController.startAction(
        name: '_FilterStoreBase.clearFilter');
    try {
      return super.clearFilter();
    } finally {
      _$_FilterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void applyFilter() {
    final _$actionInfo = _$_FilterStoreBaseActionController.startAction(
        name: '_FilterStoreBase.applyFilter');
    try {
      return super.applyFilter();
    } finally {
      _$_FilterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startStreaming() {
    final _$actionInfo = _$_FilterStoreBaseActionController.startAction(
        name: '_FilterStoreBase.startStreaming');
    try {
      return super.startStreaming();
    } finally {
      _$_FilterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
