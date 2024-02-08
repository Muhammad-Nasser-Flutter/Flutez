class SearchModel {
  String? type;
  String? id;
  String? title;
  String? description;
  Channel? channel;
  bool? isLiveNow;
  String? lengthText;
  String? viewCountText;
  String? publishedTimeText;
  List<Thumbnails>? thumbnails;

  SearchModel(
      {this.type,
        this.id,
        this.title,
        this.description,
        this.channel,
        this.isLiveNow,
        this.lengthText,
        this.viewCountText,
        this.publishedTimeText,
        this.thumbnails});

  SearchModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    title = json['title'];
    description = json['description'];
    channel =
    json['channel'] != null ? Channel.fromJson(json['channel']) : null;
    isLiveNow = json['isLiveNow'];
    lengthText = json['lengthText'];
    viewCountText = json['viewCountText'];
    publishedTimeText = json['publishedTimeText'];
    if (json['thumbnails'] != null) {
      thumbnails = <Thumbnails>[];
      json['thumbnails'].forEach((v) {
        thumbnails!.add(Thumbnails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    if (channel != null) {
      data['channel'] = channel!.toJson();
    }
    data['isLiveNow'] = isLiveNow;
    data['lengthText'] = lengthText;
    data['viewCountText'] = viewCountText;
    data['publishedTimeText'] = publishedTimeText;
    if (thumbnails != null) {
      data['thumbnails'] = thumbnails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Channel {
  String? type;
  String? id;
  String? name;
  bool? isVerified;
  bool? isVerifiedArtist;
  List<Avatar>? avatar;

  Channel(
      {this.type,
        this.id,
        this.name,
        this.isVerified,
        this.isVerifiedArtist,
        this.avatar});

  Channel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    name = json['name'];
    isVerified = json['isVerified'];
    isVerifiedArtist = json['isVerifiedArtist'];
    if (json['avatar'] != null) {
      avatar = <Avatar>[];
      json['avatar'].forEach((v) {
        avatar!.add(Avatar.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['name'] = name;
    data['isVerified'] = isVerified;
    data['isVerifiedArtist'] = isVerifiedArtist;
    if (avatar != null) {
      data['avatar'] = avatar!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Avatar {
  String? url;
  int? width;
  int? height;

  Avatar({this.url, this.width, this.height});

  Avatar.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}

class Thumbnails {
  String? url;
  int? width;
  int? height;
  bool? moving;

  Thumbnails({this.url, this.width, this.height, this.moving});

  Thumbnails.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
    moving = json['moving'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['width'] = width;
    data['height'] = height;
    data['moving'] = moving;
    return data;
  }
}
