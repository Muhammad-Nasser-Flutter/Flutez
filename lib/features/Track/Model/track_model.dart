import 'package:audio_service/audio_service.dart';

import 'artist_model.dart';

class Song {
  final String id;
  final Artist artist;
  final String title;
  final String imageUrl;
  final String? trackPath;
  final String? trackUrl;

  Song({
    this.id = "",
    required this.artist,
    required this.title,
    required this.imageUrl,
    this.trackPath,
    this.trackUrl,
  }) : assert(trackUrl != null || trackPath != null);

  factory Song.fromMediaItem(MediaItem mediaItem) {
    String? trackPath, trackUrl;
    if ((mediaItem.extras!['url'] as String).startsWith('asset:///')) {
      trackPath =
          mediaItem.extras!['url'].toString().replaceFirst('asset:///', '');
    } else {
      trackUrl = mediaItem.extras!['url'];
    }
    return Song(
        id: mediaItem.id,
        artist: Artist(id: "1", name: "${mediaItem.artist}"),
        title: mediaItem.title,
        imageUrl: mediaItem.artUri!.toString(),
        trackPath: trackPath,
        trackUrl: trackUrl);
  }

  MediaItem toMediaItem() => MediaItem(
        id: id,
        title: title,
        artist: artist.id,
        artUri: Uri.parse(imageUrl),
        extras: <String, dynamic>{
          'url': trackPath != null ? 'asset:///$trackPath' : trackUrl,
        },
      );
}
