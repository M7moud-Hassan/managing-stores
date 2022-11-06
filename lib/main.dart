import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustafa/features/catalogue/presentation/bloc/catalogue_bloc.dart';
import 'package:mustafa/features/catalogue/presentation/pages/drawer_catalogue_page.dart';
import 'package:mustafa/features/data_market/presentation/bloc/data_market_bloc.dart';
import 'injections/injection_mark_data.dart' as di;
import 'injections/injection_catalogue.dart' as di2;
import 'injections/injection_mark_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  await di2.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<DataMarketBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CatalogueBloc>()..add(GetCatalougesEvent()),
        ),
      ],
      child: const MaterialApp(
        home: DrawerCataloguePage(),
        debugShowCheckedModeBanner: false,
        title: 'mutafa',
      ),
    );
  }
}
