import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serene/blocs/sound_bloc.dart';
import 'package:serene/data/categories_repository.dart';
import 'package:serene/model/category.dart';
import 'package:serene/screens/details_view.dart';

class CategoryDetailsPage extends StatefulWidget {
  final Category category;

  CategoryDetailsPage({Key key, @required this.category}) : super(key: key);

  @override
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SoundBloc(
          repository: RepositoryProvider.of<CategoriesRepository>(context)),
      child: DetailsView(category: widget.category),
    );
  }
}
