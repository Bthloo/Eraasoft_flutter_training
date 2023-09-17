/// name : ["The name has already been taken."]

class Faildata {
  Faildata({
      this.name,});

  Faildata.fromJson(dynamic json) {
    name = json['name'] != null ? json['name'].cast<String>() : [];
  }
  List<String>? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }

}