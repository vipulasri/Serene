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
    } else if (event is FetchPlayingSounds) {
      yield* _mapFetchPlayingSoundToState(event);
    } else if (event is TogglePlayButton) {
      yield* _mapTogglePlayButtonToState(event);
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

  Stream<Result<List<Sound>>> _mapFetchPlayingSoundToState(
      FetchPlayingSounds event) async* {
    try {
      yield Success(await repository.getPlayingSounds());
    } catch (error) {
      yield Error(error);
    }
  }

  Stream<Result<List<Sound>>> _mapTogglePlayButtonToState(
      TogglePlayButton event) async* {
    try {
      List<Sound> playing = await repository.getPlayingSounds();
      if (playing.isNotEmpty) {
        yield Success(await repository.stopAllPlayingSounds());
      } else {
        yield Success(await repository.playAllPreviouslyPlayingSounds());
      }
    } catch (error) {
      yield Error(error);
    }
  }

  Stream<Result<List<Sound>>> _mapUpdateSoundToState(UpdateSound event) async* {
    try {
      await repository.updateSound(
          event.soundId, event.active, event.volume); //update
      _mapFetchSoundsToState(FetchSounds(
          categoryId:
              event.soundId.substring(0, 1))); // return the updated sounds
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

class FetchPlayingSounds extends SoundEvent {
  const FetchPlayingSounds();

  @override
  List<Object> get props => [];
}

class TogglePlayButton extends SoundEvent {
  const TogglePlayButton();

  @override
  List<Object> get props => [];
}

class UpdateSound extends SoundEvent {
  final String soundId;
  final bool active;
  final double volume;

  const UpdateSound(
      {@required this.soundId, @required this.active, @required this.volume})
      : assert(soundId != null);

  @override
  List<Object> get props => [soundId, active];
}
