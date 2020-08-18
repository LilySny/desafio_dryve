import 'package:desafio_dryve/home/models/filter_params.dart';
import 'package:desafio_dryve/home/models/vehicle.dart';
import 'package:desafio_dryve/home/pages/home/components/feedback_widget.dart';
import 'package:desafio_dryve/home/pages/home/components/vehicle_card.dart';

import 'package:desafio_dryve/home/pages/home/stores/filter_store.dart';
import 'package:desafio_dryve/home/pages/home/stores/home_store.dart';
import 'package:desafio_dryve/home/pages/home/stores/mark_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'components/filter_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeStore _homeStore;
  FilterStore _filterStore;
  ReactionDisposer _reactionDisposer;

  @override
  void didChangeDependencies() {
    _initializeStores();
    _initializeReactions();
    super.didChangeDependencies();
  }

  void _initializeStores() {
    if (_homeStore == null) {
      _homeStore = Provider.of<HomeStore>(context);
      _filterStore = Provider.of<FilterStore>(context);
      _homeStore.startStreaming();
      _filterStore.startStreaming();
    }
  }

  void _initializeReactions() {
    if (_reactionDisposer == null) {
      _homeStore.vehicles.listen((event) {
        print(event);
      });
      _reactionDisposer = reaction<FilterParams>(
          (_) => _filterStore.filter, _storesInteraction);
    }
  }

  void _storesInteraction(FilterParams filter) {
    if (filter.isEmpty) {
      _homeStore.startStreaming();
    } else {
      _homeStore.filter(filter);
    }
  }

  @override
  void dispose() {
    _reactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const TitleWidget(title: "VW Seminovos"),
        actions: const [FilterWidget()],
      ),
      backgroundColor: Colors.white,
      body: Observer(
        builder: (_) {
          final vehicles = _homeStore.vehicles;
          final items = vehicles.value;
          if (vehicles.hasError) {
            return Center(
              child: FeedbackWidget(
                title:
                    "Ocorreu um erro buscar os dados dos nossos veículos. Por favor, verifique sua conexão com a internet.",
              ),
            );
          } else if (_homeStore.isDisconnected && items == null) {
            return const Center(
              child: FeedbackWidget(
                title: "Não foi possível buscar os dados dos nossos veículos. Por favor, verique sua conexão com a internet.",
              )
            );
          } else if (items == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (_filterStore.filter != null && items.isEmpty) {
            return Center(
              child: FeedbackWidget(
                buttonTitle: "Limpar Filtros",
                title:
                    "Não encontramos nenhum veículo com essas características.",
                function: () {
                  _homeStore.startStreaming();
                },
              ),
            );
          }
          return GridView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.only(
                  top: 25, bottom: 15, left: 20, right: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 9 / 13,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                crossAxisCount: 2,
              ),
              itemBuilder: (_, int index) {
                Vehicle model = items[index];
                return VehicleCard(model: model);
              });
        },
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  final String title;
  const TitleWidget({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset("assets/rectangle.png"),
        const SizedBox(width: 10),
        Text(
          title ?? "",
          style: const TextStyle(
            fontFamily: "CircularStd",
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xff4b5670),
          ),
        ),
      ],
    );
  }
}

class FilterWidget extends StatefulWidget {
  const FilterWidget({Key key}) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  @override
  Widget build(BuildContext context) {
    final filterStore = Provider.of<FilterStore>(context);
    final markStore = Provider.of<MarkStore>(context);
    return Observer(builder: (_) {
      final amountOfFilters =
          filterStore.filterColors.length + filterStore.filterBrands.length;
      final filtersAreReady =
          filterStore.colors.value != null && markStore.brands != null;
      return Stack(
        children: [
          IconButton(
            color: Colors.black,
            padding: const EdgeInsets.all(4),
            icon: const Icon(Icons.tune),
            iconSize: 28,
            onPressed: filtersAreReady ? _showFilter : null,
          ),
          if (amountOfFilters > 0)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: 16,
                width: 16,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff0065ff),
                ),
                child: Center(
                  child: Text(
                    "$amountOfFilters",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }

  void _showFilter() {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      isScrollControlled: true,
      builder: (_) => const FilterSheetWidget(),
    );
  }
}
