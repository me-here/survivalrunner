import 'dart:convert';
import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/services.dart';

/// A service that plays audio located in the assets/audio folder.
class AudioHelper {
  static AudioCache player = AudioCache();
  static List<String> audioFileNames;

  AudioHelper() {
    _getAudioAssets();
  }

  /// This gets the names of the audio files in pubspec.
  void _getAudioAssets() async {
    final pubspecString = await rootBundle.loadString("AssetManifest.json");
    print(pubspecString);
    final Map<String, dynamic> pubspec = jsonDecode(pubspecString);
    audioFileNames = pubspec.keys
        .where((fileName) => fileName.contains("assets/audio/"))
        .toList();
  }

  /// Plays a file from assets/audio at random.
  /// Must ignore the assets/ part of the file since AudioCache adds it automatically.
  void playRandomFollowerAudio() async {
    if (audioFileNames == null) return;
    int ignore = "assets/".length;
    int randIndex = Random().nextInt(audioFileNames.length);
    String correctedFileName = audioFileNames[randIndex].substring(ignore);
    player.play(correctedFileName, volume: );
  }

  void stopAudio() async {
    
  }
}
