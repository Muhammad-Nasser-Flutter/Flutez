// class SearchModel {
//   String? type;
//   Video? video;
//
//   SearchModel({this.type, this.video});
//
//   SearchModel.fromJson(Map<String, dynamic> json) {
//     type = json['type'];
//     video = json['video'] != null ? Video.fromJson(json['video']) : null;
//   }
//
// }
//
// class Video {
//   Author? author;
//   List<String>? badges;
//   String? descriptionSnippet;
//   bool? isLiveNow;
//   dynamic lengthSeconds;
//   String? publishedTimeText;
//   Stats? stats;
//   List<Thumbnails>? thumbnails;
//   String? title;
//   String? videoId;
//
//   Video(
//       {this.author,
//         this.badges,
//         this.descriptionSnippet,
//         this.isLiveNow,
//         this.lengthSeconds,
//         this.publishedTimeText,
//         this.stats,
//         this.thumbnails,
//         this.title,
//         this.videoId});
//
//   Video.fromJson(Map<String, dynamic> json) {
//     author =
//     json['author'] != null ? Author.fromJson(json['author']) : null;
//     badges = json['badges'].cast<String>();
//     descriptionSnippet = json['descriptionSnippet'];
//     isLiveNow = json['isLiveNow'];
//     lengthSeconds = json['lengthSeconds'];
//     publishedTimeText = json['publishedTimeText'];
//     stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
//     if (json['thumbnails'] != null) {
//       thumbnails = <Thumbnails>[];
//       json['thumbnails'].forEach((v) {
//         thumbnails!.add(Thumbnails.fromJson(v));
//       });
//     }
//     title = json['title'];
//     videoId = json['videoId'];
//   }
//
// }
//
// class Thumbnails {
//   dynamic height;
//   dynamic width;
//   String? url;
//   Thumbnails({this.width,this.height,this.url,});
//   Thumbnails.fromJson(Map<String,dynamic> json){
//     height = json["height"];
//     width = json["width"];
//     url = json["url"];
//   }
// }
//
// class Author {
//   List<Avatar>? avatar;
//   List<Badges>? badges;
//   String? channelId;
//   String? title;
//
//   Author(
//       {this.avatar,
//         this.badges,
//         this.channelId,
//         this.title});
//
//   Author.fromJson(Map<String, dynamic> json) {
//     if (json['avatar'] != null) {
//       avatar = <Avatar>[];
//       json['avatar'].forEach((v) {
//         avatar!.add(Avatar.fromJson(v));
//       });
//     }
//     if (json['badges'] != null) {
//       badges = <Badges>[];
//       json['badges'].forEach((v) {
//         badges!.add(Badges.fromJson(v));
//       });
//     }
//     channelId = json['channelId'];
//     title = json['title'];
//   }
//
// }
//
// class Avatar {
//   dynamic height;
//   String? url;
//   dynamic width;
//
//   Avatar({this.height, this.url, this.width});
//
//   Avatar.fromJson(Map<String, dynamic> json) {
//     height = json['height'];
//     url = json['url'];
//     width = json['width'];
//   }
//
// }
//
// class Badges {
//   String? text;
//   String? type;
//
//   Badges({this.text, this.type});
//
//   Badges.fromJson(Map<String, dynamic> json) {
//     text = json['text'];
//     type = json['type'];
//   }
//
// }
//
// class Stats {
//   int? views;
//
//   Stats({this.views});
//
//   Stats.fromJson(Map<String, dynamic> json) {
//     views = json['views'];
//   }
//
// }


// class SearchModel {
//   String? videoId;
//   String? title;
//   String? thumbnail;
//   String? author;
//   String? duration;
//
//   SearchModel(
//       {this.videoId, this.title, this.thumbnail, this.author, this.duration});
//
//   SearchModel.fromJson(Map<String, dynamic> json) {
//     videoId = json['videoId'];
//     title = json['title'];
//     thumbnail = json['thumbnail'];
//     author = json['author'];
//     duration = json['duration'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['videoId'] = videoId;
//     data['title'] = title;
//     data['thumbnail'] = thumbnail;
//     data['author'] = author;
//     data['duration'] = duration;
//     return data;
//   }
// }


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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['url'] = url;
    data['width'] = width;
    data['height'] = height;
    data['moving'] = moving;
    return data;
  }
}
