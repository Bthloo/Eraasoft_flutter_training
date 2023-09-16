import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider extends ChangeNotifier{
  String? token ;
  getToken()async{
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    this.token = token;
   // return token;
}
}