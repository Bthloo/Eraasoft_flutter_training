/// failemail : ["The email has already been taken."]
/// failphone : ["The phone has already been taken."]
/// faildepartment_id : ["This department already has manager."]

class Faildata {
  Faildata({
      this.failemail, 
      this.failphone, 
      this.faildepartmentId,});

  Faildata.fromJson(dynamic json) {
    failemail = json['failemail'] != null ? json['failemail'].cast<String>() : [];
    failphone = json['failphone'] != null ? json['failphone'].cast<String>() : [];
    faildepartmentId = json['faildepartment_id'] != null ? json['faildepartment_id'].cast<String>() : [];
  }
  List<String>? failemail;
  List<String>? failphone;
  List<String>? faildepartmentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['failemail'] = failemail;
    map['failphone'] = failphone;
    map['faildepartment_id'] = faildepartmentId;
    return map;
  }

}