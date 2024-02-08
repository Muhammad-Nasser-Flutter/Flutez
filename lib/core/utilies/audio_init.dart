
import 'package:just_audio_background/just_audio_background.dart';

void initAudio()async{
  await JustAudioBackground.init(
    androidNotificationChannelId: "com.ryanheise.bg_demo.channel.audio",
    androidNotificationChannelName: "Audio Playback",
    androidNotificationOngoing: true,
  );
}