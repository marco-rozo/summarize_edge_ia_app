import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:summary_app/core/externals/audio_recorder/audio_recorder_external.dart';
import 'package:summary_app/core/externals/permission_manager/enums/permission_manager_status_enum.dart';
import 'package:summary_app/core/externals/permission_manager/permission_manager.dart';

class AudioRecorderExternalImpl implements IAudioRecorderExternal {
  final AudioRecorder _audioRecorder;
  final PermissionManager _permissionManager;
  final Logger _logger;

  AudioRecorderExternalImpl({
    AudioRecorder? audioRecorder,
    required PermissionManager permissionManager,
    Logger? logger,
  })  : _audioRecorder = audioRecorder ?? AudioRecorder(),
        _permissionManager = permissionManager,
        _logger = logger ?? Logger();

  @override
  Future<void> startRecording(String fileName) async {
    final permissionStatus =
        await _permissionManager.requestMicrophonePermission();

    if (permissionStatus != PermissionManagerStatusEnum.granted &&
        permissionStatus != PermissionManagerStatusEnum.limited) {
      throw Exception('Permissão de microfone negada para gravação de áudio.');
    }

    final directory = await getApplicationDocumentsDirectory();
    final cleanFileName =
        fileName.endsWith('.wav') ? fileName : '$fileName.wav';
    final filePath = '${directory.path}/$cleanFileName';

    const config = RecordConfig(
      encoder: AudioEncoder.wav,
      sampleRate: 16000,
      numChannels: 1,
    );

    _logger.i('Iniciando gravação de áudio no caminho: $filePath');
    await _audioRecorder.start(config, path: filePath);
  }

  @override
  Future<void> pauseRecording() async {
    _logger.i('Pausando gravação de áudio');
    await _audioRecorder.pause();
  }

  @override
  Future<void> resumeRecording() async {
    _logger.i('Retomando gravação de áudio');
    await _audioRecorder.resume();
  }

  @override
  Future<String?> stopRecording() async {
    _logger.i('Parando gravação de áudio');
    final filePath = await _audioRecorder.stop();
    _logger.i('Gravação parada. Arquivo salvo em: $filePath');
    return filePath;
  }

  @override
  Future<void> dispose() async {
    _logger.i('Liberando recursos do AudioRecorder');
    await _audioRecorder.dispose();
  }
}
