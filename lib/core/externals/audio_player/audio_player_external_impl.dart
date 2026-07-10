import 'package:audioplayers/audioplayers.dart';
import 'package:logger/logger.dart';
import 'package:summary_app/core/externals/audio_player/audio_player_external.dart';

class AudioPlayerExternalImpl implements IAudioPlayerExternal {
  final AudioPlayer _audioPlayer;
  final Logger _logger;

  AudioPlayerExternalImpl({
    AudioPlayer? audioPlayer,
    Logger? logger,
  })  : _audioPlayer = audioPlayer ?? AudioPlayer(),
        _logger = logger ?? Logger();

  @override
  Future<void> play(String filePath) async {
    _logger.i('Iniciando reprodução do áudio: $filePath');
    await _audioPlayer.play(DeviceFileSource(filePath));
  }

  @override
  Future<void> pause() async {
    _logger.i('Pausando reprodução de áudio');
    await _audioPlayer.pause();
  }

  @override
  Future<void> resume() async {
    _logger.i('Retomando reprodução de áudio');
    await _audioPlayer.resume();
  }

  @override
  Future<void> stop() async {
    _logger.i('Parando reprodução de áudio');
    await _audioPlayer.stop();
  }

  @override
  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  @override
  Future<Duration?> getDuration(String filePath) async {
    await _audioPlayer.setSource(DeviceFileSource(filePath));
    return _audioPlayer.getDuration();
  }

  @override
  Stream<Duration> get onPositionChanged => _audioPlayer.onPositionChanged;

  @override
  Stream<PlayerState> get onPlayerStateChanged =>
      _audioPlayer.onPlayerStateChanged;

  @override
  Stream<void> get onPlayerComplete => _audioPlayer.onPlayerComplete;

  @override
  Future<void> dispose() async {
    _logger.i('Liberando recursos do AudioPlayer');
    await _audioPlayer.dispose();
  }
}
