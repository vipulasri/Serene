import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:serene/data/categories_repository.dart';
import 'package:serene/model/category.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoriesRepository repository;

  CategoryBloc({@required this.repository}) : assert(repository != null);

  @override
  CategoryState get initialState => CategoryEmpty();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is FetchCategories) {
      yield* _mapFetchCategoriesToState(event);
    }
  }

  Stream<CategoryState> _mapFetchCategoriesToState(
      FetchCategories event) async* {
    yield CategoryLoading();
    try {
      yield CategoryLoaded(categories: await repository.loadCategories());
    } catch (_) {
      yield CategoryError();
    }
  }
}

// Events
abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class FetchCategories extends CategoryEvent {
  const FetchCategories();

  @override
  List<Object> get props => [];
}

// States
abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryEmpty extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;

  const CategoryLoaded({@required this.categories})
      : assert(categories != null);

  @override
  List<Object> get props => [categories];
}

class CategoryError extends CategoryState {}
