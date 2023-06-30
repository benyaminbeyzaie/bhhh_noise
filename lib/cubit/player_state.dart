part of 'player_cubit.dart';

abstract class PlayerState {}

class PlayerLoading extends PlayerState {}

class PlayerStarted extends PlayerState {
  Map<int, NoisePlayerModel> noisePlayers;
  Set<String> savedNoises;

  PlayerStarted({
    required this.noisePlayers,
    required this.savedNoises,
  });
}

class NoiseSaved extends PlayerStarted {
  NoiseSaved({
    required super.noisePlayers,
    required super.savedNoises,
  });
}
