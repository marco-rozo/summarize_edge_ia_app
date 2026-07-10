import 'package:audioplayers/audioplayers.dart';

abstract class IAudioPlayerExternal {
  Future<void> play(String filePath);
  Future<void> pause();
  Future<void> resume();
  Future<void> stop();
  Future<void> seek(Duration position);
  Future<Duration?> getDuration(String filePath);
  Stream<Duration> get onPositionChanged;
  Stream<PlayerState> get onPlayerStateChanged;
  Stream<void> get onPlayerComplete;
  Future<void> dispose();
}
