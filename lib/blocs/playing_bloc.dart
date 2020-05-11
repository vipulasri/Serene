import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:serene/blocs/result_state.dart';
import 'package:serene/data/repository.dart';
import 'package:serene/model/playing_sounds.dart';
import 'package:serene/model/sound.dart';

class PlayingSoundsBloc extends Bloc<PlayingSoundsEvent, Result> {
  final DataRepository repository;

  PlayingSoundsBloc({@required this.repository}) : assert(repository != null);

  @override
  Result get initialState => Empty();

  @override
  Stream<Result> mapEventToState(PlayingSoundsEvent event) async* {
    if (event is FetchPlayingSounds) {
      yield* _mapFetchSelectedSoundToState(event);
    } else if (event is TogglePlayButton) {
      yield* _mapTogglePlayButtonToState(event);
    } else if (event is UpdateSoundVolume) {
      yield* _mapUpdateSoundVolume(event);
    } else if (event is StopSound) {
      yield* _mapStopSoundToState(event);
    }
  }

  Stream<Result<PlayingData>> _mapFetchSelectedSoundToState(FetchPlayingSounds event) async* {
    try {
      PlayingData data = PlayingData(
          isPlaying: repository.isPlaying,
          isRandom: repository.isPlayingRandom(),
          playing: await repository.getSelectedSounds()
      );

      yield Success(data);

    } catch (error) {
      yield Error(error);
    }
  }

  Stream<Result<PlayingData>> _mapTogglePlayButtonToState(TogglePlayButton event) async* {
    try {

      PlayingData data = PlayingData(
          isPlaying: repository.isPlaying,
          isRandom: repository.isPlayingRandom(),
          playing: []
      );

      // check if sounds are playing
      if (data.isPlaying) {

        // check if playing sound is random
        if(data.isRandom) {
          await repository.stopRandom();
        } else {
          data.playing = await repository.stopAllPlayingSounds();
        }

      } else {
        // check if there are any selected sounds
        if((await repository.getSelectedSounds()).isEmpty) {
          await repository.playRandom();
          data.playing = await repository.getSelectedSounds();
        } else {
          data.playing = await repository.playAllSelectedSounds();
        }
      }

      data.isPlaying = repository.isPlaying;
      data.isRandom = repository.isPlayingRandom();
      
      yield Success(data);
      
    } catch (error) {
      yield Error(error);
    }
  }

  Stream<Result<PlayingData>> _mapUpdateSoundVolume(UpdateSoundVolume event) async* {
    try {
      await repository.updateSound(event.soundId, true, event.volume); //update
      yield* _mapFetchSelectedSoundToState(FetchPlayingSounds());
    } catch (error) {
      yield Error(error);
    }
  }

  Stream<Result<PlayingData>> _mapStopSoundToState(StopSound event) async* {
    try {
      await repository.updateSound(event.soundId, false, 5); //update
      yield* _mapFetchSelectedSoundToState(FetchPlayingSounds());
    } catch (error) {
      yield Error(error);
    }
  }
}

// Events
abstract class PlayingSoundsEvent extends Equatable {
  const PlayingSoundsEvent();
}

class FetchPlayingSounds extends PlayingSoundsEvent {
  const FetchPlayingSounds();

  @override
  List<Object> get props => [];
}

class TogglePlayButton extends PlayingSoundsEvent {
  const TogglePlayButton();

  @override
  List<Object> get props => [];
}

class UpdateSoundVolume extends PlayingSoundsEvent {
  final String soundId;
  final double volume;

  const UpdateSoundVolume(
      {@required this.soundId,
        @required this.volume
      })
      : assert(soundId != null, volume != null);

  @override
  List<Object> get props => [soundId];
}

class StopSound extends PlayingSoundsEvent {
  final String soundId;

  const StopSound(
      {@required this.soundId})
      : assert(soundId != null);

  @override
  List<Object> get props => [soundId];
}
