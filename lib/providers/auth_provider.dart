import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider extends ChangeNotifier{
  String? token ;
  String? userType ;
  int? userId;
  getToken()async{
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    String? userType = await storage.read(key: 'userType');
    this.token = token;
    this.userType = userType;
   // return token;
}
}