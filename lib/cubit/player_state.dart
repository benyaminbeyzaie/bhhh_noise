part of 'player_cubit.dart';

abstract class PlayerState {}

class PlayerStarted extends PlayerState {
  Map<int, NoisePlayerModel> noisePlayers;

  PlayerStarted({required this.noisePlayers});
}
