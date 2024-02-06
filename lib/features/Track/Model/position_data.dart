import 'package:just_audio/just_audio.dart';

class PositionData {
  PositionData(this.position, this.bufferedPosition, this.duration, this.playerState,this.sequenceState,);
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
  final PlayerState playerState;
  SequenceState? sequenceState;
}