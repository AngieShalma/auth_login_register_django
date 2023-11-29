import 'package:flutter/material.dart';
import 'package:test_api_register_login_logout/screens/login_screen.dart';
import 'package:test_api_register_login_logout/screens/register_screen.dart';

class welcomeScreen extends StatelessWidget {
  const welcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          SizedBox(height: 75,),
          Text("   Deaf App",style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xff0AAB98)
          ),),
          SizedBox(height: 35,),
          Center(
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: ((context) => loginScreen())));
              },
              child: Container(
                height: 100,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff0AAB98),
                ),
                child: Center(
                  child: Text("login",style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),),
                ),
              ),
            ),
          ),
          SizedBox(height: 25,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: ((context) => registerScreen())));

            },
            child: Container(
              height: 100,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff0AAB98),
              ),
              child: Center(
                child: Text("Sign Up",style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
