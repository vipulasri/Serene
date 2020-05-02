import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serene/blocs/blocs.dart';
import 'package:serene/blocs/sound_bloc.dart';
import 'package:serene/data/repository.dart';
import 'package:serene/screens/home/home_page.dart';

import 'blocs/simple_bloc_delegate.dart';

Future<void> main() async {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<DataRepository>(
      create: (_) => DataRepository(),
      child: BlocProvider(
        create: (context) => CategoryBloc(
            repository: RepositoryProvider.of<DataRepository>(context)),
        child: app(),
      ),
    );
  }

  Widget app() {
    return MaterialApp(
      title: 'Serene',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ).copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CategoryBloc(
                repository:
                    RepositoryProvider.of<DataRepository>(context)),
          ),
          BlocProvider(
            create: (context) => SoundBloc(
                repository:
                    RepositoryProvider.of<DataRepository>(context)),
          ),
        ],
        child: HomePage(),
      ),
    );
  }
}
