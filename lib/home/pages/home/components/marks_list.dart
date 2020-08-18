import 'package:desafio_dryve/home/pages/home/components/brand_check_box.dart';
import 'package:desafio_dryve/home/pages/home/stores/filter_store.dart';
import 'package:desafio_dryve/home/pages/home/stores/mark_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MarksList extends StatefulWidget {
  const MarksList({Key key}) : super(key: key);
  @override
  _MarksListState createState() => _MarksListState();
}

class _MarksListState extends State<MarksList> {
  MarkStore _markStore;
  FilterStore _filterStore;

  @override
  void didChangeDependencies() {
    _initializeStores();
    super.didChangeDependencies();
  }

  void _initializeStores() {
    if (_filterStore == null) {
      _markStore = Provider.of<MarkStore>(context);
      _filterStore = Provider.of<FilterStore>(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(top: 5),
            child: const Text(
              "Marca",
              style: TextStyle(
                color: Color(0xff1e2c4c),
                fontFamily: "CircularStd",
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 25),
          child: TextFormField(
            initialValue: _markStore.searchTerm,
            onChanged: (e) {
              _markStore.searchTerm = e;
              _markStore.filter();
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0.5,
                  style: BorderStyle.solid,
                  color: Color.fromRGBO(118, 128, 149, 1),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0.5,
                  style: BorderStyle.solid,
                  color: Color.fromRGBO(118, 128, 149, 1),
                ),
              ),
              hintText: "Buscar por nome...",
              isDense: true,
              hintStyle: const TextStyle(
                color: Color.fromRGBO(118, 128, 149, 1),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 11,
                horizontal: 16,
              ),
              suffixIcon: const Icon(Icons.search, size: 24),
            ),
          ),
        ),
        Observer(
          builder: (_) {
            if (_markStore.brands.value == null) {
              return Container();
            }
            final brands = _markStore.brands.value;
            return ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: brands.length,
                itemBuilder: (_, int index) {
                  final brand = brands[index];

                  return Observer(builder: (_) {
                    final filterBrands = _filterStore.filterBrands;

                    final isMarked = filterBrands.contains(brand.brandId);
                    return BrandCheckBox(
                      brand: brand,
                      isMarked: isMarked,
                    );
                  });
                });
          },
        ),
      ],
    );
  }
}
