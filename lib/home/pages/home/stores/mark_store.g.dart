// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MarkStore on _MarkStoreBase, Store {
  final _$_searchTermAtom = Atom(name: '_MarkStoreBase._searchTerm');

  @override
  String get _searchTerm {
    _$_searchTermAtom.reportRead();
    return super._searchTerm;
  }

  @override
  set _searchTerm(String value) {
    _$_searchTermAtom.reportWrite(value, super._searchTerm, () {
      super._searchTerm = value;
    });
  }

  final _$_brandsAtom = Atom(name: '_MarkStoreBase._brands');

  @override
  ObservableStream<List<Brand>> get _brands {
    _$_brandsAtom.reportRead();
    return super._brands;
  }

  @override
  set _brands(ObservableStream<List<Brand>> value) {
    _$_brandsAtom.reportWrite(value, super._brands, () {
      super._brands = value;
    });
  }

  final _$_MarkStoreBaseActionController =
      ActionController(name: '_MarkStoreBase');

  @override
  void filter() {
    final _$actionInfo = _$_MarkStoreBaseActionController.startAction(
        name: '_MarkStoreBase.filter');
    try {
      return super.filter();
    } finally {
      _$_MarkStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startStreaming() {
    final _$actionInfo = _$_MarkStoreBaseActionController.startAction(
        name: '_MarkStoreBase.startStreaming');
    try {
      return super.startStreaming();
    } finally {
      _$_MarkStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
