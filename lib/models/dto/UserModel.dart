class UserModel {
  late int id;
  late String email;
  late String avatar_url;
  late String name;
  late String address;
  late String bio;
  late String date_of_birth;
  late String gender;

  UserModel({
    this.id = -1,
    this.email = '',
    this.avatar_url = '',
    this.name = '',
    this.address = '',
    this.bio = '',
    this.date_of_birth = '',
    this.gender = '',
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    avatar_url = json['avatar_url'];
    name = json['name'];
    address = json['address'];
    bio = json['bio'];
    date_of_birth = json['date_of_birth'];
    gender = json['gender'];
  }

  String getAddress() {
    return address;
  }

  void update(
      {required String name, required String email, required String address}) {
    this.name = name;
    this.email = email;
    this.address = address;
  }

  /*
  {
  "email": "user@example.com",
  "avatar_url": "string",
  "name": "string",
  "bio": "string",
  "address": "string",
  "date_of_birth": "2024-01-06T09:19:43.656Z",
  "gender": "MALE"
}
   */

  Map<String, dynamic> toMapJson() {
    return {
      'bio' : 'deptrai',
      'email': email,
      'name': name,
      'address': address,
    };
  }
}
