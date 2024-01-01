class RecommendedTrackModel {
  String? videoId;
  String? title;
  String? thumbnail;
  String? author;

  RecommendedTrackModel({
    this.videoId,
    this.title,
    this.thumbnail,
    this.author,
  });

  RecommendedTrackModel.fromJson(Map<String, dynamic> json) {
    videoId = json['videoId'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['videoId'] = videoId;
    data['title'] = title;
    data['thumbnail'] = thumbnail;
    data['author'] = author;
    return data;
  }
}
