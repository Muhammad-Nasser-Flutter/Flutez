class PlaylistModel {
  String? image;
  String? title;
  String? shadowColor;
  List<Track>? tracks;

  PlaylistModel({this.image, this.title, this.shadowColor, this.tracks});

  PlaylistModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    shadowColor = json['shadowColor'];
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
    data['shadowColor'] = shadowColor;
    if (tracks != null) {
      data['tracks'] = tracks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Track {
  String? image;
  String? artist;
  int? nextId;
  String? trackLink;
  String? trackName;
  int? id;
  String? shadowColor;

  Track(
      {this.image,
        this.nextId,
        this.trackLink,
        this.trackName,
        this.artist,
        this.id,
        this.shadowColor});

  Track.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    artist = json['artist'];
    nextId = json['nextId'];
    trackLink = json['trackLink'];
    trackName = json['trackName'];
    id = json['id'];
    shadowColor = json['shadowColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['image'] = image;
    data['artist'] = artist;
    data['nextId'] = nextId;
    data['trackLink'] = trackLink;
    data['trackName'] = trackName;
    data['id'] = id;
    data['shadowColor'] = shadowColor;
    return data;
  }
}
