import 'dart:convert';
import 'dart:io';
import 'package:flutez/core/cache_helper/cache_helper.dart';
import 'package:flutez/core/constant.dart';
import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/utilies/easy_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutez/features/Downloads/models/downloaded_track_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

class DownloadedTracksCubit extends Cubit<List<DownloadedTrackModel>> {
  DownloadedTracksCubit() : super(<DownloadedTrackModel>[]);
  Future<String> downloadAndSaveTrackInTheDevice(String url, String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      // Check if file already exists
      if (!await File(filePath).exists()) {
        final response = await http.get(Uri.parse(url));
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
      }

      return filePath;
    } catch (e) {
      throw Exception('Failed to download music: $e');
    }
  }

  Future<String> downloadAndSaveTrackImageInTheDevice(String url, String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      // Check if file already exists
      if (!await File(filePath).exists()) {
        final response = await http.get(Uri.parse(url));
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
      }

      return filePath;
    } catch (e) {
      throw Exception('Failed to download music: $e');
    }
  }

  Future<void> getDownloadedTracks() async {
    try {
      final List<String> downloadedTracksAsListOfStrings =
          CacheHelper.sharedPreferences.getStringList(DOWNLOADED_TRACKS) ?? [];
      final List<DownloadedTrackModel> downloadedTracks = downloadedTracksAsListOfStrings
          .map(
            (stringTrack) => DownloadedTrackModel.fromJson(jsonDecode(stringTrack)),
          )
          .toList();
      emit(downloadedTracks);
    } catch (e) {
      print(e.toString());
      emit(const []);
    }
  }

  Future<void> addTrackToDownloadedTracks({
    required String id,
    required String trackUrl,
    required String imageUrl,
    required String artist,
    required String trackName,
  }) async {
    showLoading();
    try {
      final List<String> downloadedTracksAsListOfStrings =
          CacheHelper.sharedPreferences.getStringList(DOWNLOADED_TRACKS) ?? [];
      downloadedTracksAsListOfStrings.add(
        jsonEncode({
          'id': await downloadAndSaveTrackInTheDevice(trackUrl, '$trackName.mp3'),
          'title': trackName,
          'artist': artist,
          'localPath': await downloadAndSaveTrackInTheDevice(trackUrl, '$trackName.mp3'),
          'localImagePath': await downloadAndSaveTrackImageInTheDevice(imageUrl, trackName),
        }),
      );
      CacheHelper.sharedPreferences.setStringList(DOWNLOADED_TRACKS, downloadedTracksAsListOfStrings);
      final tracks = downloadedTracksAsListOfStrings
          .map(
            (stringTrack) => DownloadedTrackModel.fromJson(jsonDecode(stringTrack)),
          )
          .toList();
      emit(tracks);
      hideLoading();
    } catch (e) {
      hideLoading();
      emit(const []);
    }
  }

  Future<void> removeTrackFromDownloadedTracks({
    required String trackName,
    required AudioPlayer audioPlayer,
    required BuildContext screenContext,
  }) async {
    showLoading();
    try {
      // 1. Update the playlist
      await updatePlaylist(audioPlayer: audioPlayer, trackName: trackName);
      // 2. Get the current list of downloaded tracks
      final List<String> downloadedTracksAsListOfStrings =
          CacheHelper.sharedPreferences.getStringList(DOWNLOADED_TRACKS) ?? [];

      // 3. Find the track to be removed before filtering
      final trackToRemove = downloadedTracksAsListOfStrings.firstWhere(
        (stringTrack) => jsonDecode(stringTrack)['title'] == trackName,
        orElse: () => '',
      );

      // 4. If track found, delete the actual file
      if (trackToRemove.isNotEmpty) {
        final trackData = jsonDecode(trackToRemove);
        final String? filePath = trackData['localPath']; // Assuming you store the file path

        if (filePath != null) {
          final file = File(filePath);
          if (await file.exists()) {
            await file.delete();
          }
        }
      }

      // 5. Filter out the track from the list
      final List<String> filteredTracks = downloadedTracksAsListOfStrings.where((stringTrack) {
        return jsonDecode(stringTrack)['title'] != trackName;
      }).toList();

      // 6. Update shared preferences
      await CacheHelper.sharedPreferences.setStringList(DOWNLOADED_TRACKS, filteredTracks);

      // 7. Update state
      final tracks = filteredTracks
          .map(
            (stringTrack) => DownloadedTrackModel.fromJson(jsonDecode(stringTrack)),
          )
          .toList();
      emit(tracks);
      hideLoading();
      // if (screenContext.mounted&&state.isEmpty) {
      //   screenContext.pop();
      // }
    } catch (e) {
      print('Error removing track: $e'); // Add logging for debugging
      hideLoading();
      emit(const []);
    }
  }

  Future<void> updatePlaylist({required AudioPlayer audioPlayer, required String trackName}) async {
    // 1. Check if the track is currently playing and handle playback
    if (audioPlayer.playing) {
      final currentTrack = audioPlayer.sequenceState?.currentSource?.tag;
      if (currentTrack != null && currentTrack.title == trackName) {
        // If this is the last track in the queue
        if (audioPlayer.hasNext) {
          // Skip to next track before removing
          await audioPlayer.seekToNext();
        } else {
          // Stop playback if no next track
          await audioPlayer.stop();
        }
      }
    }

    // 2. Update the playlist/queue

    final playlist = audioPlayer.sequence?.toList() ?? [];

    final updatedPlaylist = playlist.where((source) {
      final metadata = source.tag;

      return metadata.title != trackName;
    }).toList();

    await audioPlayer.setAudioSource(
      ConcatenatingAudioSource(children: updatedPlaylist),
      initialIndex: 0,
      initialPosition: Duration.zero,
    );
  }
}
