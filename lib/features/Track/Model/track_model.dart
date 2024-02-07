class Track {
  String? image;
  String? artist;
  String? trackLink;
  String? trackName;

  Track(
      {this.image,
        this.trackLink,
        this.trackName,
        this.artist,
      });

  Track.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    artist = json['artist'];
    trackLink = json['trackLink'];
    trackName = json['trackName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['image'] = image;
    data['artist'] = artist;
    data['trackLink'] = trackLink;
    data['trackName'] = trackName;
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