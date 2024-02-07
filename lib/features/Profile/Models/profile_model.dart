class ProfileModel {
  String? uId;
  String? image;
  String? name;
  String? email;

  ProfileModel({this.uId, this.image, this.name, this.email});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    image = json['image'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['uId'] = uId;
    data['image'] = image;
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}
