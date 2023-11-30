import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart'as http;
import 'package:test_api_register_login_logout/shared/network/shared_preferences.dart';

import 'main.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

void register(
    {required String userName,required String email
      ,required String password,required String isDeaf})async{
  emit(RegisterLoadingState());
  try{
http.Response response= await http.post(
    Uri.parse("http://10.0.2.2:8000/api/register/"),
  body:
  {"username": userName,
    "password": password,
    "email": email,
    "isDeaf":isDeaf,

  });
var responseBody=jsonDecode(response.body.toString());
  print("response:${responseBody}");
  print("responsetype${responseBody['isDeaf'].runtimeType}");
  await CacheNetwork.insertToCache(key:"token",value:responseBody['token']);
  //////////////////

  await CacheNetwork.deleteIsDeaffCacheItem(key: 'registerIsDeaf');
  await CacheNetwork.insertIsDeaffToCache(key: "registerIsDeaf", value: responseBody['isDeaf'].toLowerCase());

  debugPrint("user register sucess data is:$responseBody");
if(response.statusCode==200){
  print("responsetype::::::${responseBody['isDeaf'].runtimeType}");
  print("responsetype::::::${responseBody['isDeaf']}");

  emit(RegisterSucessState());
}else{
  print("failed");
  emit(RegisterFailedState());
}}catch(e){
    print(e);
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
     print("responsetype${data['isDeaf'].runtimeType}");
     await CacheNetwork.deleteIsDeaffCacheItem(key: 'loginIsDeaf');


     await CacheNetwork.insertToCache(key:"token",value:data['token']);
     await CacheNetwork.insertIsDeaffToCache(key: "loginIsDeaf", value: data['isDeaf'].toLowerCase());
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
void logOut({required String token}) async{
  emit(LogoutLoadingState());

  try{
    http.Response response= await http.post(
        Uri.parse("http://10.0.2.2:8000/api/logout/"),
        headers:
        {
          "Authorization":"Token ${token} "

        });

    /////////////
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      print("responsetype${data['message'].runtimeType}");
      print("responsetype${data['message']}");


      await CacheNetwork.deleteCacheItem(key: "token");
      await CacheNetwork.deleteIsDeaffCacheItem(key: 'loginIsDeaf');

      await CacheNetwork.deleteIsDeaffCacheItem(key: 'registerIsDeaf');

      print("login isDeaf value:$loginIsDeaf ");
      print("register IsDeaf value:$registerIsDeaf ");
      emit(LogoutSucessState());
    }else{
      //emit(RegisterFailedState());
      debugPrint("user login data is:${data}");
    }
  }catch(e){
    print(e);
    emit(LogoutFailedState());

  }
}
}
