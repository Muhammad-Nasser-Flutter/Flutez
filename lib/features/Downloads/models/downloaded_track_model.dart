class DownloadedTrackModel {
  String id;
  String title;
  String artist;
  String localPath;
  String localImagePath;

  DownloadedTrackModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.localPath,
    required this.localImagePath,
  });

  factory DownloadedTrackModel.fromJson(Map<String, dynamic> json) {
    return DownloadedTrackModel(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      localPath: json['localPath'],
      localImagePath: json['localImagePath'],
    );
  }
  Map<String,dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'localPath': localPath,
      'localImagePath': localImagePath,
    };
  }
}
