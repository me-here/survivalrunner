import 'package:audioplayers/audio_cache.dart';

/// A service that plays audio located in the assets/audio folder.
class AudioHelper {
  static AudioCache player = AudioCache();

  void playLocalFile() async {
    player.play('audio/run_forrest_run.m4a');
  }
}
