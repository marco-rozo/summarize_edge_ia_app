abstract class IAudioRecorderExternal {
  Future<void> startRecording(String fileName);
  Future<void> pauseRecording();
  Future<void> resumeRecording();
  Future<String?> stopRecording();
  Future<void> dispose();
}
