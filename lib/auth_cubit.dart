import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart'as http;
import 'package:test_api_register_login_logout/shared/network/shared_preferences.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

void register(
    {required String userName,required String email
      ,required String password,required String isDeaf})async{
  emit(RegisterLoadingState());
http.Response response= await http.post(
    Uri.parse("http://10.0.2.2:8000/api/register/"),
  body:
  {"username": userName,
    "password": password,
    "email": email,
    "isDeaf":isDeaf,

  });
var responseBody=jsonDecode(response.body);
  print("response:${responseBody}");
  await CacheNetwork.insertToCache(key:"token",value:responseBody['token']);
  await CacheNetwork.insertIsDeaffToCache(key: "isDeaff", value: responseBody['isDeaf']).toString();
  print("responsetype${responseBody['isDeaf'].runtimeType}");
  debugPrint("user register sucess data is:$responseBody");
if(response.statusCode==200){
emit(RegisterSucessState());
}else{
  print("failed");
  emit(RegisterFailedState());
}
}

void login({required String userName,required String password})async{
  emit(LoginLoadingState());

 try{
   http.Response response= await http.post(
       Uri.parse("http://10.0.2.2:8000/api/login/"),
       body:
       {"username": userName,
         "password": password,

       });
   /////////////
   var data=jsonDecode(response.body.toString());
   if(response.statusCode==200){


     await CacheNetwork.insertToCache(key:"token",value:data['token']);
     await CacheNetwork.insertIsDeaffToCache(key: "isDeaff", value: data['isDeaf']);
     debugPrint("user login sucess data is:${data['isDeaf']}");
      emit(LoginSucessState());
   }else{
     //emit(RegisterFailedState());
     debugPrint("user login data is:${data}");
   }
 }catch(e){
   print(e);
   emit(LoginFailedState());

 }
}
}
