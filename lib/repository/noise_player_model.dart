class NoisePlayerModel {
  final int id;
  final String name;
  bool playing;
  double volume;
  final String url;
  final String icon;

  NoisePlayerModel({
    required this.id,
    required this.name,
    required this.playing,
    required this.volume,
    required this.url,
    required this.icon,
  });
}

Map<int, NoisePlayerModel> staticNoisePlayMap = {
  0: NoisePlayerModel(
    id: 0,
    name: "Bass",
    playing: false,
    volume: 0.5,
    url:
        "https://assets.mixkit.co/sfx/download/mixkit-suspense-mystery-bass-685.wav",
    icon: "🤟",
  ),
  1: NoisePlayerModel(
    id: 1,
    name: "Bird",
    playing: false,
    volume: 0.5,
    url:
        "https://assets.mixkit.co/sfx/download/mixkit-little-birds-singing-in-the-trees-17.wav",
    icon: "🐧",
  ),
  2: NoisePlayerModel(
    id: 2,
    name: "Airport",
    playing: false,
    volume: 0.5,
    url:
        "https://assets.mixkit.co/sfx/download/mixkit-airport-departures-hall-357.wav",
    icon: "✈️",
  ),
  3: NoisePlayerModel(
    id: 3,
    name: "Crowd",
    playing: false,
    volume: 0.5,
    url:
        "https://assets.mixkit.co/sfx/download/mixkit-big-crowd-talking-loop-364.wav",
    icon: "💁‍♂️",
  ),
  4: NoisePlayerModel(
    id: 4,
    name: "Type",
    playing: false,
    volume: 0.5,
    url:
        "https://assets.mixkit.co/sfx/download/mixkit-keyboard-typing-1386.wav",
    icon: "💻",
  ),
  5: NoisePlayerModel(
    id: 5,
    name: "Fire",
    playing: false,
    volume: 0.5,
    url:
        "https://assets.mixkit.co/sfx/download/mixkit-campfire-crackles-1330.wav",
    icon: "🔥",
  ),
};
