import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serene/blocs/blocs.dart';
import 'package:serene/config/assets.dart';
import 'package:serene/data/categories_repository.dart';
import 'package:serene/screens/home.dart';

import 'blocs/simple_bloc_delegate.dart';

Image backgroundImage;

Future<Uint8List> loadImage(String url) {
  ImageStreamListener listener;

  final Completer<Uint8List> completer = Completer<Uint8List>();
  final ImageStream imageStream =
      AssetImage(url).resolve(ImageConfiguration.empty);

  listener = ImageStreamListener(
    (ImageInfo imageInfo, bool synchronousCall) {
      imageInfo.image
          .toByteData(format: ImageByteFormat.png)
          .then((ByteData byteData) {
        imageStream.removeListener(listener);
        completer.complete(byteData.buffer.asUint8List());
      });
    },
    onError: (dynamic exception, StackTrace stackTrace) {
      imageStream.removeListener(listener);
      completer.completeError(exception);
    },
  );

  imageStream.addListener(listener);

  return completer.future;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadImage(Assets.homeBackground);
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      home: BlocProvider(
        create: (context) => CategoryBloc(
          repository: CategoriesRepository()
        ),
        child: HomePage(),
      ),
    );
  }
}
