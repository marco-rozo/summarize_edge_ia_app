import 'package:logger/logger.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:summary_app/core/externals/speech_recognizer/speech_recognizer.dart';

class SpeechRecognizerImpl implements SpeechRecognizer {
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isAvailable = false;
  
  String _sessionAccumulatedWords = '';
  String _lastRecognizedWords = '';
  var log = Logger();

  void Function(String status)? _onStatus;
  void Function(dynamic error)? _onError;

  @override
  Future<bool> initialize({
    void Function(String status)? onStatus,
    void Function(dynamic error)? onError,
  }) async {
    if (onStatus != null) _onStatus = onStatus;
    if (onError != null) _onError = onError;

    _isAvailable = await _speechToText.initialize(
      onStatus: _onStatus,
      onError: (e) => _onError?.call(e),
    );
    return _isAvailable;
  }

  @override
  Future<void> startListening({
    required void Function(String recognizedText, bool isFinal) onResult,
    String localeId = 'pt_BR',
  }) async {
    if (!_isAvailable) {
      final initialized = await initialize();
      if (!initialized) return;
    }

    _sessionAccumulatedWords = '';
    _lastRecognizedWords = '';

    await _speechToText.listen(
      onResult: (SpeechRecognitionResult result) {
        final currentWords = result.recognizedWords.trim();
        if (currentWords.isEmpty) return;

        bool isReset = false;
        
        if (_lastRecognizedWords.isNotEmpty) {
           final lastFirst = _lastRecognizedWords.split(' ').firstWhere((e) => e.isNotEmpty, orElse: () => '');
           final currentFirst = currentWords.split(' ').firstWhere((e) => e.isNotEmpty, orElse: () => '');
           
           if (lastFirst.isNotEmpty && currentFirst.isNotEmpty) {
               if (currentFirst.toLowerCase() != lastFirst.toLowerCase()) {
                   isReset = true;
               } else if (currentWords.length < _lastRecognizedWords.length * 0.5) {
                   isReset = true;
               }
           }
        }

        if (result.finalResult) {
           isReset = true;
        }

        if (isReset) {
           _sessionAccumulatedWords = _sessionAccumulatedWords.isEmpty 
               ? _lastRecognizedWords 
               : '$_sessionAccumulatedWords $_lastRecognizedWords'.trim();
               
           if (result.finalResult) {
               _lastRecognizedWords = '';
               _sessionAccumulatedWords = _sessionAccumulatedWords.isEmpty 
                   ? currentWords 
                   : '$_sessionAccumulatedWords $currentWords'.trim();
           } else {
               _lastRecognizedWords = currentWords;
           }
        } else {
           _lastRecognizedWords = currentWords;
        }

        final fullSessionText = _sessionAccumulatedWords.isEmpty 
            ? _lastRecognizedWords
            : '$_sessionAccumulatedWords $_lastRecognizedWords'.trim();

        onResult(fullSessionText, result.finalResult);
      },
      listenOptions: stt.SpeechListenOptions(
        listenMode: stt.ListenMode.dictation,
        cancelOnError: false,
        partialResults: true,
        localeId: localeId,
        pauseFor: const Duration(seconds: 20),
        listenFor: const Duration(seconds: 120),
      ),
    );
  }

  @override
  Future<void> stopListening() async {
    await _speechToText.stop();
  }

  @override
  bool get isListening => _speechToText.isListening;

  @override
  bool get isAvailable => _isAvailable;
}
