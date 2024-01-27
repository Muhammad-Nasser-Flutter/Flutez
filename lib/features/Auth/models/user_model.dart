class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.image,
  });

  UserModel.fromJson(Map<String,dynamic> json){
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
  }

  Map<String,dynamic> toJson(){
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'image':image,
    };
  }


}