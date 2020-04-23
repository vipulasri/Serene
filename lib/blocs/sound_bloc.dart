import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:serene/blocs/result_state.dart';
import 'package:serene/data/categories_repository.dart';
import 'package:serene/model/sound.dart';

class SoundBloc extends Bloc<SoundEvent, Result> {
  final CategoriesRepository repository;

  SoundBloc({@required this.repository}) : assert(repository != null);

  @override
  Result get initialState => Empty();

  @override
  Stream<Result> mapEventToState(SoundEvent event) async* {
    if (event is FetchSounds) {
      yield* _mapFetchSoundsToState(event);
    } else if (event is UpdateSound) {
      yield* _mapUpdateSoundToState(event);
    }
  }

  Stream<Result<List<Sound>>> _mapFetchSoundsToState(FetchSounds event) async* {
    yield Loading();
    try {
      yield Success(await repository.loadSounds(event.categoryId));
    } catch (error) {
      yield Error(error);
    }
  }

  Stream<Result<List<Sound>>> _mapUpdateSoundToState(UpdateSound event) async* {
    try {
      await repository.updateSound(event.soundId, event.isActive); //update
      _mapFetchSoundsToState(FetchSounds(categoryId: event.soundId.substring(0, 1))); // return the updated sounds
    } catch (error) {
      yield Error(error);
    }
  }
}

// Events
abstract class SoundEvent extends Equatable {
  const SoundEvent();
}

class FetchSounds extends SoundEvent {
  final String categoryId;

  const FetchSounds({@required this.categoryId}) : assert(categoryId != null);

  @override
  List<Object> get props => [categoryId];
}

class UpdateSound extends SoundEvent {
  final String soundId;
  final bool isActive;

  const UpdateSound({@required this.soundId, @required this.isActive})
      : assert(soundId != null);

  @override
  List<Object> get props => [soundId, isActive];
}
