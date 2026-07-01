abstract class SpeechRecognizer {
  Future<bool> initialize({
    void Function(String status)? onStatus,
    void Function(dynamic error)? onError,
  });

  Future<void> startListening({
    required void Function(String recognizedText, bool isFinal) onResult,
    String localeId = 'pt_BR',
  });

  Future<void> stopListening();

  bool get isListening;

  bool get isAvailable;
}
