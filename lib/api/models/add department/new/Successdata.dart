/// id : 53
/// name : "Department testhkkxx"
/// manager : null

class Successdata {
  Successdata({
      this.id, 
      this.name, 
      this.manager,});

  Successdata.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    manager = json['manager'];
  }
  int? id;
  String? name;
  dynamic manager;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['manager'] = manager;
    return map;
  }

}