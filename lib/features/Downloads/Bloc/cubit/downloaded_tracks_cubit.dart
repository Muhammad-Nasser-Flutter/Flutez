import 'dart:convert';
import 'dart:io';
import 'package:flutez/core/cache_helper/cache_helper.dart';
import 'package:flutez/core/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutez/features/Downloads/models/downloaded_track_model.dart';
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
    try {
      final List<String> downloadedTracksAsListOfStrings =
          CacheHelper.sharedPreferences.getStringList(DOWNLOADED_TRACKS) ?? [];
      downloadedTracksAsListOfStrings.add(
        jsonEncode({
          'id': id,
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
    } catch (e) {
      print(e.toString());

      emit(const []);
    }
  }
}
