class DeleteDepartmentResponse {
  DeleteDepartmentResponse({
    required this.message,
    required this.data,
    required this.status,
    required this.code,
  });
 String? message;
 List<dynamic>? data;
 bool? status;
 int? code;

  DeleteDepartmentResponse.fromJson(Map<String, dynamic> json){
    message = json['message'];
    data = List.castFrom<dynamic, dynamic>(json['data']);
    status = json['status'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['data'] = data;
    data['status'] = status;
    data['code'] = code;
    return data;
  }
}