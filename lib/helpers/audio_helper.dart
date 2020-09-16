import 'dart:convert';
import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

/// A service that plays audio located in the assets/audio folder.
class AudioHelper {
  static final player = AudioPlayer();
  static final _cache = AudioCache(fixedPlayer: player);
  static List<String> _audioFileNames;

  AudioHelper() {
    _getAudioAssets();
  }

  /// This gets the names of the audio files in pubspec.
  void _getAudioAssets() async {
    final pubspecString = await rootBundle.loadString("AssetManifest.json");
    print(pubspecString);
    final Map<String, dynamic> pubspec = jsonDecode(pubspecString);
    _audioFileNames = pubspec.keys
        .where((fileName) => fileName.contains("assets/audio/"))
        .toList();
  }

  /// Plays a file from assets/audio at random.
  /// Must ignore the assets/ part of the file since AudioCache adds it automatically.
  void playRandomFollowerAudio() async {
    if (_audioFileNames == null) return;
    int ignore = "assets/".length;
    int randIndex = Random().nextInt(_audioFileNames.length);

    String correctedFileName = _audioFileNames[randIndex].substring(ignore);
    _cache.play(correctedFileName);
  }

  /// Set volume given input double from 0.0 to 1.0
  void setVolume(double volume) async {
    player.setVolume(volume);
  }

  void stopAudio() async {
    player.stop();
  }
}
