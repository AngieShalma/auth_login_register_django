import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_api_register_login_logout/auth_cubit.dart';
import 'package:test_api_register_login_logout/screens/home_screen.dart';
import 'package:test_api_register_login_logout/screens/welcome_screen.dart';
import 'package:test_api_register_login_logout/shared/network/shared_preferences.dart';
String? token;
String? D;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await CacheNetwork.cacheInitalization();
  token =await CacheNetwork.getCacheData(key: 'token');
  D = CacheNetwork.getIsDeaffCacheData(key:'isDeaff');


  print("token is:$token ");
  print("isDeaf value:$D ");
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>AuthCubit(),

        ),
      ],
      child: MaterialApp(
  debugShowCheckedModeBanner: false,
        home:token !=null &&token !=""?homeScreen(): welcomeScreen(),
      ),
    );
  }
}

