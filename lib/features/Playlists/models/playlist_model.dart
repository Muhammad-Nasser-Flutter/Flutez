import '../../Track/Model/track_model.dart';

class PlaylistModel {
  String? image;
  String? title;
  List<Track>? tracks;

  PlaylistModel({this.image, this.title, this.tracks});

  PlaylistModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    if (json['tracks'] != null) {
      tracks = <Track>[];
      json['tracks'].forEach((v) {
        tracks!.add(Track.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['image'] = image;
    data['title'] = title;
    if (tracks != null) {
      data['tracks'] = tracks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


