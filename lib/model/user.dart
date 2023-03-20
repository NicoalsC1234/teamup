import 'dart:convert';

List<MyUser> myUserFromJson(String str) => List<MyUser>.from(json.decode(str).map((x) => MyUser.fromJson(x)));

String myUserToJson(List<MyUser> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyUser {
  MyUser({
    this.image,
    required this.id,
    required this.age,
    required this.description,
    required this.name,
    required this.email,
  });

  int age;
  String description;
  String? image;
  String name;
  String id;
  String email;

  Map<String, Object?> toFirebaseMap({String? newImage}) {
    return <String, Object?>{
      'id': id ,
      'name': name,
      'email': email,
      'age': age,
      'description': description,
      'image': newImage ?? image,
    };
  }

  MyUser.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        name = data['name'] as String,
        email = data['email'] as String,
        age = data['age'] as int,
        description = data['description'] as String,
        image = data['image'] as String?;

  factory MyUser.fromJson(Map<String, dynamic> json) => MyUser(
    age: json["age"],
    description: json["description"],
    image: json["image"],
    name: json["name"],
    id: json["id"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "age": age,
    "description": description,
    "image": image,
    "name": name,
    "id": id,
    "email": email,
  };
}
