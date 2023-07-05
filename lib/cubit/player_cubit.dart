import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bhhh_noise/repository/noise_player_model.dart';
import 'package:bhhh_noise/repository/player_repository.dart';

part 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  final PlayerRepository repository;

  PlayerCubit({
    required this.repository,
  }) : super(
          PlayerNormalState(
            noisePlayers: repository.getNoisePlayersMapStatus,
            savedNoises: repository.getSavedNoiseNames(),
          ),
        );

  void playSavedNoise({required String name}) async {
    emit(PlayerLoading());
    await repository.playSavedNoise(name);
    emit(
      PlayerNormalState(
        noisePlayers: repository.getNoisePlayersMapStatus,
        savedNoises: repository.getSavedNoiseNames(),
      ),
    );
  }

  void saveNoise({required String name}) async {
    await repository.saveCurrentNoise(name);
    emit(
      NoiseSaved(
        noisePlayers: repository.getNoisePlayersMapStatus,
        savedNoises: repository.getSavedNoiseNames(),
      ),
    );
  }

  void deleteSavedNoise({required String name}) async {
    await repository.deleteSavedNoise(name);
    emit(
      PlayerNormalState(
        noisePlayers: repository.getNoisePlayersMapStatus,
        savedNoises: repository.getSavedNoiseNames(),
      ),
    );
  }

  void toggleNoise({required int id}) async {
    repository.toggleNoise(id: id);
    emit(
      PlayerNormalState(
        noisePlayers: repository.getNoisePlayersMapStatus,
        savedNoises: repository.getSavedNoiseNames(),
      ),
    );
  }

  void setVolume({
    required int id,
    required double volume,
  }) async {
    await repository.setVolume(id: id, volume: volume);
    emit(
      PlayerNormalState(
        noisePlayers: repository.getNoisePlayersMapStatus,
        savedNoises: repository.getSavedNoiseNames(),
      ),
    );
  }

  void randomizePlay() async {
    await repository.randomizePlay();
    emit(
      PlayerNormalState(
        noisePlayers: repository.getNoisePlayersMapStatus,
        savedNoises: repository.getSavedNoiseNames(),
      ),
    );
  }

  void stopAll() async {
    await repository.stopAll();
    emit(
      PlayerStopped(
        noisePlayers: repository.getNoisePlayersMapStatus,
        savedNoises: repository.getSavedNoiseNames(),
      ),
    );
  }
}
