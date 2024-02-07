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


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Track &&
              image == other.image &&
              trackLink == other.trackLink &&
              trackName == other.trackName &&
              artist == other.artist;

  @override
  int get hashCode => image.hashCode ^artist.hashCode ^ trackName.hashCode ^ trackLink.hashCode ;

}