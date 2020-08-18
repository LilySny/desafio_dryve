import 'package:desafio_dryve/home/pages/home/components/brand_check_box.dart';
import 'package:desafio_dryve/home/pages/home/components/color_circle.dart';
import 'package:desafio_dryve/home/pages/home/components/filter_sheet_button.dart';
import 'package:desafio_dryve/home/pages/home/components/bottom_sheet_app_bar.dart';
import 'package:desafio_dryve/home/pages/home/components/marks_list.dart';
import 'package:desafio_dryve/home/pages/home/stores/filter_store.dart';
import 'package:desafio_dryve/home/pages/home/stores/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

const kStrongBlueColor = Color(0xff0065ff);

class FilterSheetWidget extends StatefulWidget {
  const FilterSheetWidget({
    Key key,
  }) : super(key: key);

  @override
  _FilterSheetWidgetState createState() => _FilterSheetWidgetState();
}

class _FilterSheetWidgetState extends State<FilterSheetWidget> {
  FilterStore _filterStore;
  HomeStore _homeStore;

  @override
  void didChangeDependencies() {
    _homeStore = Provider.of<HomeStore>(context);
    _filterStore = Provider.of<FilterStore>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.83,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetAppBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const MarksList(),
                      const Divider(
                        color: Color(0xffdddddd),
                        thickness: 1,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: const Text(
                            "Cor",
                            style: TextStyle(
                              color: Color(0xff1e2c4c),
                              fontFamily: "CircularStd",
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Observer(
                        builder: (_) {
                          final colors = _filterStore.colors.value;

                          if (_filterStore.colors.data == null) {
                            return Container();
                          }

                          return GridView.builder(
                              itemCount: colors.length,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 15,
                                crossAxisCount: 2,
                                childAspectRatio: 12 / 3,
                              ),
                              itemBuilder: (_, int index) {
                                final color = colors[index];
                                return Observer(
                                  builder: (_) {
                                    final filterColors =
                                        _filterStore.filterColors;

                                    final isSelected = filterColors.contains(
                                      color.colorId,
                                    );
                                    return ColorCircle(
                                      isMarked: isSelected,
                                      color: color.color,
                                      title: color.name,
                                      colorId: color.colorId,
                                    );
                                  },
                                );
                              });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 20, bottom: 10, left: 20, right: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FilterSheetButtonWidget(
                      onPressed: () {
                        _filterStore.clearFilter();
                        _homeStore.startStreaming();
                        Navigator.pop(context);
                      },
                      label: "Limpar",
                      labelColor: kStrongBlueColor,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: FilterSheetButtonWidget(
                      onPressed: () {
                        _filterStore.applyFilter();
                        Navigator.pop(context);
                      },
                      label: "Aplicar",
                      backgroundColor: kStrongBlueColor,
                      labelColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
