class UserData {
  UserData({
    required this.users,
  });
  late final List<Users> users;

  UserData.fromJson(Map<String, dynamic> json){
    users = List.from(json['users']).map((e)=>Users.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['users'] = users.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Users {
  Users({
    required this.name,
    required this.id,
    required this.atype,
    required this.age,
    required this.gender,
  });
  late final String name;
  late final String id;
  late final String atype;
  late final String age;
  late final String gender;

  Users.fromJson(Map<String, dynamic> json){
    name = json['name'];
    id = json['id'];
    atype = json['atype'];
    age = json['age'] ?? "";
    gender = json['gender'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['id'] = id;
    _data['atype'] = atype;
    _data['age'] = age;
    _data['gender'] = gender;
    return _data;
  }
}