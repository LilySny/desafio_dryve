import 'package:desafio_dryve/home/models/brand.dart';
import 'package:desafio_dryve/home/pages/home/stores/filter_store.dart';
import 'package:flutter/material.dart';
import 'package:desafio_dryve/shared/utils/string_filter_utils.dart';
import 'package:provider/provider.dart';

class BrandCheckBox extends StatefulWidget {
  final Brand brand;
  final bool isMarked;

  const BrandCheckBox({
    Key key,
    @required this.brand,
    @required this.isMarked,
  }) : super(key: key);

  @override
  _BrandCheckBoxState createState() => _BrandCheckBoxState();
}

class _BrandCheckBoxState extends State<BrandCheckBox> {
  FilterStore _filterStore;

  @override
  void didChangeDependencies() {
    _filterStore = Provider.of<FilterStore>(context);
    super.didChangeDependencies();
  }

  void _addOrRemove() {
    if (!_filterStore.filterBrands.contains(widget.brand.brandId)) {
      _filterStore.filterBrands.add(widget.brand.brandId);
    } else {
      _filterStore.filterBrands.remove(widget.brand.brandId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: InkWell(
        onTap: _addOrRemove,
        child: Row(
          children: <Widget>[
            Checkbox(
              value: widget.isMarked,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (e) {
                _addOrRemove();
              },
            ),
            const SizedBox(width: 20),
            Image.asset(widget.brand.imagePath),
            const SizedBox(width: 20),
            Text(
              widget.brand.name.decapitalize(),
              style: const TextStyle(color: Color.fromRGBO(118, 128, 149, 1)),
            ),
          ],
        ),
      ),
    );
  }
}
