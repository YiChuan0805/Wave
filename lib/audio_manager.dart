import 'package:assets_audio_player/assets_audio_player.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  factory AudioManager() {
    return _instance;
  }

  AudioManager._internal();
}
