/// id : 10
/// name : "Department testh"
/// manager : null

class Data {
  Data({
      this.id, 
      this.name, 
      this.manager,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    manager = json['manager'];
  }
  int? id;
  List? name;
  dynamic manager;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['manager'] = manager;
    return map;
  }

}