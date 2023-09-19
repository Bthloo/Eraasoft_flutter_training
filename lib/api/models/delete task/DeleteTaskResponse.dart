/// message : "Deleted Successfuly."
/// data : []
/// status : true
/// code : 200

class DeleteTaskResponse {
  DeleteTaskResponse({
      this.message, 
      this.status,
      this.code,});

  DeleteTaskResponse.fromJson(dynamic json) {
    message = json['message'];
    status = json['status'];
    code = json['code'];
  }
  String? message;
  bool? status;
  int? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['status'] = status;
    map['code'] = code;
    return map;
  }

}