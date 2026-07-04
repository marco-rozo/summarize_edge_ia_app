enum AiModelTaskTypeEnum {
  textToText('text-to-text', 'Geração textual', 'Transformer / LLM'),
  audioToText('audio-to-text', 'ASR (Reconhecimento de Fala)', 'ASR Acústico'),
  textToImage('text-to-image', 'Geração de Imagem', 'Difusão / Transformer'),
  imageToText(
    'image-to-text',
    'Visão / Descrição de Imagem',
    'Transformer Multimodal',
  ),
  textToAudio('text-to-audio', 'TTS (Síntese de Fala)', 'Acústico / Vocoder'),
  anyToAny('any-to-any', 'Multimodal Geral', 'Transformer Multimodal');

  final String value;
  final String label;
  final String architectureLabel;

  const AiModelTaskTypeEnum(this.value, this.label, this.architectureLabel);

  factory AiModelTaskTypeEnum.fromValue(String? val) {
    if (val == null || val.trim().isEmpty) {
      return AiModelTaskTypeEnum.textToText;
    }
    final lower = val.trim().toLowerCase();
    for (final e in AiModelTaskTypeEnum.values) {
      if (e.value.toLowerCase() == lower || e.name.toLowerCase() == lower) {
        return e;
      }
    }
    if (lower.contains('audio') || lower == 'asr') {
      return AiModelTaskTypeEnum.audioToText;
    }
    if (lower.contains('image') ||
        lower.contains('img') ||
        lower.contains('vision')) {
      return AiModelTaskTypeEnum.imageToText;
    }
    return AiModelTaskTypeEnum.textToText;
  }
}
