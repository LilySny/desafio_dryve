import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:desafio_dryve/home/interfaces/brand_dao.dart';
import 'package:desafio_dryve/home/interfaces/color_facade.dart';
import 'package:desafio_dryve/home/interfaces/favorite_dao.dart';
import 'package:desafio_dryve/home/interfaces/offline_sync_facade.dart';
import 'package:desafio_dryve/home/interfaces/vehicle_facade.dart';
import 'package:desafio_dryve/home/pages/home/home_page.dart';
import 'package:desafio_dryve/home/pages/home/stores/favorite_store.dart';
import 'package:desafio_dryve/home/pages/home/stores/filter_store.dart';
import 'package:desafio_dryve/home/pages/home/stores/home_store.dart';
import 'package:desafio_dryve/home/pages/home/stores/mark_store.dart';
import 'package:desafio_dryve/home/data/hive_brand_dao.dart';
import 'package:desafio_dryve/home/data/hive_color_dao.dart';
import 'package:desafio_dryve/home/data/hive_favorite_dao.dart';
import 'package:desafio_dryve/home/data/hive_vehicle_dao.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  OfflineSyncFacade _offlineSyncFacade;

  @override
  void initState() {
    _offlineSyncFacade = OfflineSyncFacade.create();
    _offlineSyncFacade.syncDataWithNetwork();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) {
          return HomeStore(HiveVehicleDao(), DataConnectionChecker());
        }),
        Provider(create: (_) {
          return FilterStore(HiveColorDao());
        }),
        Provider(
          create: (_) {
            return FavoriteStore(HiveFavoriteDao());
          },
          lazy: false,
        ),
        Provider(
          create: (_) {
            return MarkStore(HiveBrandDao());
          },
          lazy: false,
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "CircularStd",
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (_) => const HomePage(),
        },
      ),
    );
  }
}
