import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceTranslator extends StatefulWidget {
  const VoiceTranslator({super.key});

  @override
  State<VoiceTranslator> createState() => _VoiceTranslatorState();
}


class _VoiceTranslatorState extends State<VoiceTranslator> {
  stt.SpeechToText? _speech;
  bool _isListening = false;
  String? _textSpeech = 'Press the button to start speaking';
  void onListen()async{
    if(!_isListening){
      bool available=await _speech!.initialize(
        onStatus: (val)=>print('on status:$val'),
        onError: (val)=>print('on status:$val'),
      );

      if(available){
        setState(() {
          _isListening=true;
        });
        _speech!.listen(onResult: (val)=>setState(() {
          _textSpeech=val.recognizedWords;
        }));
      }
      else{
        setState(() {
          _isListening=false;
          _speech!.stop();
        });
      }
    }}
  // @override
  // void initState() {
  //   super.initState();
  //   _speech = stt.SpeechToText();
  // }

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
        glowColor: Theme.of(context).primaryColor,
        animate: _isListening,
        endRadius: 80,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),repeat: true,
        child: FloatingActionButton(
          onPressed: () {
            onListen();
          },
          child: Icon(_isListening?Icons.mic:Icons.mic_none),
        ));
  }
}
