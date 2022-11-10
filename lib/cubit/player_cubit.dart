import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bhhh_noise/repository/noise_player_model.dart';
import 'package:bhhh_noise/repository/player_repository.dart';

part 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  final PlayerRepository repository;

  PlayerCubit({
    required this.repository,
  }) : super(PlayerStarted(noisePlayers: repository.getNoisePlayersMapStatus));

  void toggleNoise({required int id}) {
    repository.toggleNoise(id: id);
    emit(PlayerStarted(noisePlayers: repository.getNoisePlayersMapStatus));
  }

  void setVolume({
    required int id,
    required double volume,
  }) {
    repository.setVolume(id: id, volume: volume);
    emit(PlayerStarted(noisePlayers: repository.getNoisePlayersMapStatus));
  }

  void randomizePlay() {
    repository.randomizePlay();
    emit(PlayerStarted(noisePlayers: repository.getNoisePlayersMapStatus));
  }

  void stopAll() {
    repository.stopAll();
    emit(PlayerStarted(noisePlayers: repository.getNoisePlayersMapStatus));
  }
}
