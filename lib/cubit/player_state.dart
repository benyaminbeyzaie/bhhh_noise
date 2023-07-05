part of 'player_cubit.dart';

abstract class PlayerState {}

class PlayerLoading extends PlayerState {}

class PlayerNormalState extends PlayerState {
  Map<int, NoisePlayerModel> noisePlayers;
  Set<String> savedNoises;

  PlayerNormalState({
    required this.noisePlayers,
    required this.savedNoises,
  });
}

class PlayerStopped extends PlayerNormalState {
  PlayerStopped({
    required super.noisePlayers,
    required super.savedNoises,
  });
}

class NoiseSaved extends PlayerNormalState {
  NoiseSaved({
    required super.noisePlayers,
    required super.savedNoises,
  });
}
