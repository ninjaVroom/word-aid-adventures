import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/foundation.dart';

void clickPlaySound() {
  AudioPlayer audioPlayer = AudioPlayer();
  audioPlayer.play(AssetSource('audio/click.mp3'));
  Timer(const Duration(seconds: 3), () {
    audioPlayer.stop();
  });
}

void playYaySound() {
  AudioPlayer audioPlayer = AudioPlayer();
  audioPlayer.play(AssetSource('audio/yay.mp3'));
  Timer(const Duration(seconds: 3), () {
    audioPlayer.stop();
  });
}

AudioPlayer playBackgroundAudioWithLoop() {
  AudioPlayer audioPlayer = AudioPlayer();
  audioPlayer.setReleaseMode(ReleaseMode.loop).then((value) => audioPlayer.play(
        AssetSource('audio/background_audio.mp3'),
        volume: 25,
      ));

  // audioPlayer.onPlayerComplete.listen((event) async {
  //   if (kDebugMode) {
  //     print({"completed": "completed"});
  //   }
  //   audioPlayer
  //       .stop()
  //       .then((value) => audioPlayer = playBackgroundAudioWithLoop());
  // });

  return audioPlayer;
}

void stopBackgroundAudioPlayer(AudioPlayer audioPlayer) {
  print({"audioPlayer": audioPlayer});
  audioPlayer.stop();
  audioPlayer.stop();
  audioPlayer.stop();
}
