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


class SearchModel {
  String? videoId;
  String? title;
  String? thumbnail;
  String? author;
  String? duration;

  SearchModel(
      {this.videoId, this.title, this.thumbnail, this.author, this.duration});

  SearchModel.fromJson(Map<String, dynamic> json) {
    videoId = json['videoId'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    author = json['author'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['videoId'] = videoId;
    data['title'] = title;
    data['thumbnail'] = thumbnail;
    data['author'] = author;
    data['duration'] = duration;
    return data;
  }
}
