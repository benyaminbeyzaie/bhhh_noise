import 'dart:convert';
import 'dart:math';

import 'package:bhhh_noise/sl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:bhhh_noise/repository/noise_player_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerRepository {
  Map<int, NoisePlayerModel> noisePlayersMap;
  late SharedPreferences preferences;

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

  Set<String> getSavedNoiseNames() {
    return sl<SharedPreferences>().getKeys();
  }

  String serializePlayers() {
    final list = List<Map<String, dynamic>>.empty(growable: true);
    for (final player in noisePlayersMap.entries) {
      if (player.value.playing) {
        list.add(player.value.toJson());
      }
    }
    return json.encode({"value": list});
  }

  Future<void> saveCurrentNoise(String name) async {
    final preferences = sl<SharedPreferences>();
    if (preferences.get(name) != null) {
      throw Exception("The name already exists");
    }

    await preferences.setString(name, serializePlayers());
  }

  Future<void> playSavedNoise(String name) async {
    final preferences = sl<SharedPreferences>();
    final saved = preferences.get(name);
    if (saved == null) {
      throw Exception("There is no saved noise with that name");
    }

    final Map<String, dynamic> playersMap = json.decode(saved as String);

    final List<dynamic> players =
        playersMap["value"].map((e) => NoisePlayerModel.fromJson(e)).toList();

    await stopAll();
    for (NoisePlayerModel element in players) {
      await playNoise(id: element.id);
      await setVolume(id: element.id, volume: element.volume);
    }
  }

  Future<void> playNoise({required int id}) async {
    noisePlayersMap[id]!.playing = true;
    await players[id]!.play();
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

  Future<void> stopAll() async {
    for (final element in players.entries) {
      noisePlayersMap[element.key]!.playing = false;
      await element.value.stop();
    }
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
