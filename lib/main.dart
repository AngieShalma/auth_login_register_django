import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_api_register_login_logout/auth_cubit.dart';
import 'package:test_api_register_login_logout/screens/home_screen.dart';
import 'package:test_api_register_login_logout/screens/welcome_screen.dart';
import 'package:test_api_register_login_logout/shared/network/shared_preferences.dart';
String? token;
String? loginIsDeaf;
String? registerIsDeaf;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await CacheNetwork.cacheInitalization();
  token =await CacheNetwork.getCacheData(key: 'token');
  loginIsDeaf = await CacheNetwork.getIsDeaffCacheData(key:'loginIsDeaf').toLowerCase();
  registerIsDeaf = await CacheNetwork.getIsDeaffCacheData(key:'registerIsDeaf').toLowerCase();


  print("token is:$token ");
  print("login isDeaf value:$loginIsDeaf ");
  print("register IsDeaf value:$registerIsDeaf ");

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
        home: welcomeScreen(),//token !=null &&token !=""?homeScreen(): welcomeScreen(),
      ),
    );
  }
}

