import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_api_register_login_logout/screens/welcome_screen.dart';
import 'package:test_api_register_login_logout/shared/network/shared_preferences.dart';

import '../auth_cubit.dart';
import '../main.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 175,),
          Text("home page",style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color(0xff0AAB98),
            decoration:TextDecoration.none,
          ),),
          SizedBox(height: 300,),
          GestureDetector(
            onTap: (){
              BlocProvider.of<AuthCubit>(context).logOut(token: token!);
              Navigator.pushAndRemoveUntil<void>(context, MaterialPageRoute(builder: ((context) => welcomeScreen())),(Route<dynamic> route) => false);

            },
            child: Container(
              height: 80,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff0AAB98),
              ),
              child: Center(
                child: Text("logout",style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  decoration:TextDecoration.none,
                ),),
              ),
            ),
          ),
          TextButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(

                builder: ((context) => welcomeScreen())));
          }, child:Text("welcome page",style: TextStyle(
              color: Color(0xff0AAB98),fontSize: 18),),)
        ],
      ),
    );
  }
}
