class ProfileModel {
  String? uId;
  String? image;
  String? phone;
  String? name;
  String? email;

  ProfileModel({this.uId, this.image, this.phone, this.name, this.email});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    image = json['image'];
    phone = json['phone'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['uId'] = uId;
    data['image'] = image;
    data['phone'] = phone;
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}
