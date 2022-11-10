import 'dart:math';

import 'package:just_audio/just_audio.dart';
import 'package:bhhh_noise/repository/noise_player_model.dart';

class PlayerRepository {
  Map<int, NoisePlayerModel> noisePlayersMap;
  late Map<int, AudioPlayer> players;

  PlayerRepository({
    required this.noisePlayersMap,
  }) {
    players = {};
    noisePlayersMap.forEach((key, value) {
      players[key] = AudioPlayer();
      players[key]!.setUrl(value.url);
      players[key]!.setLoopMode(LoopMode.one);
      players[key]!.setVolume(0.5);
    });
  }

  Future<void> toggleNoise({required int id}) async {
    if (noisePlayersMap[id]!.playing) {
      noisePlayersMap[id]!.playing = false;
      await players[id]!.stop();
    } else {
      noisePlayersMap[id]!.playing = true;
      await players[id]!.play();
    }
  }

  Future<void> setVolume({
    required int id,
    required double volume,
  }) async {
    noisePlayersMap[id]!.volume = volume;
    await players[id]!.setVolume(volume);
  }

  void stopAll() {
    players.forEach((key, value) async {
      noisePlayersMap[key]!.playing = false;
      await value.stop();
    });
  }

  void randomizePlay() {
    Random random = Random();
    players.forEach((key, value) async {
      if (random.nextBool()) {
        noisePlayersMap[key]!.playing = true;
        noisePlayersMap[key]!.volume = random.nextDouble();
        players[key]!.setVolume(noisePlayersMap[key]!.volume);
        await players[key]!.play();
      } else {
        noisePlayersMap[key]!.playing = false;
        await players[key]!.stop();
      }
    });
  }

  Map<int, NoisePlayerModel> get getNoisePlayersMapStatus => noisePlayersMap;
}
