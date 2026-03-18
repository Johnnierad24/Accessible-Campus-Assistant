import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

typedef VoiceResultCallback = void Function(String transcript);

class VoiceService {
  VoiceService._();
  static final VoiceService instance = VoiceService._();

  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();

  bool _available = false;

  Future<void> init() async {
    await Permission.microphone.request();
    _available = await _speech.initialize();
  }

  bool get isAvailable => _available;

  Future<void> listenForText(VoiceResultCallback onResult) async {
    if (!_available) return;
    await _speech.listen(
        onResult: (SpeechRecognitionResult result) {
          if (result.finalResult && result.recognizedWords.isNotEmpty) {
            onResult(result.recognizedWords);
          }
        },
        pauseFor: const Duration(seconds: 2),
        listenFor: const Duration(seconds: 10));
  }

  Future<void> stopListening() async {
    await _speech.stop();
  }

  Future<void> speak(String text) async {
    await _tts.stop();
    await _tts.speak(text);
  }
}
