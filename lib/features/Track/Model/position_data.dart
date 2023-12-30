import 'package:just_audio/just_audio.dart';

class PositionData {
  const PositionData(this.position, this.bufferedPosition, this.duration, this.state);
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
  final PlayerState state;
}