import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_api_register_login_logout/auth_cubit.dart';
import 'package:test_api_register_login_logout/auth_cubit.dart';
import 'package:test_api_register_login_logout/main.dart';
import 'package:test_api_register_login_logout/screens/register_screen.dart';

import '../shared/network/shared_preferences.dart';
import 'deaf_home_screen.dart';
import 'home_screen.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool eye = true;
  late String UserName;
  late String password;

  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>
      (listener: (context, state) async {
      loginIsDeaf = await CacheNetwork.getIsDeaffCacheData(key:'loginIsDeaf').toLowerCase();

      print("value$loginIsDeaf");

      if(state is LoginSucessState && loginIsDeaf=="false"){
        Navigator.pushReplacement(context, MaterialPageRoute(

            builder: ((context) => homeScreen())));
      }else if(state is LoginSucessState && loginIsDeaf=="true"){
        Navigator.pushReplacement(context, MaterialPageRoute(

            builder: ((context) => deafHomeScreen())));
      }if(state is LoginFailedState){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(
          alignment: Alignment.center,
          child: Text("something wrong try again"),)));
      }
      },

      builder: (context, state) {
        return Scaffold(
          body: Form(
            key: _formkey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 55,),
                    Text("  Deaf App", style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff0AAB98)
                    ),),
                    SizedBox(height: 35,),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(

                        controller: nameController,
                        validator: (value) {
                          if (nameController.text == null ||
                              nameController.text.isEmpty) {
                            return 'please enter Your Name';
                          }
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          focusColor: Color(0xff0AAB98),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xff0AAB98),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Color(0xff0AAB98),
                              width: 2.0,
                            ),
                          ),
                          labelText: 'enter your Name',

                          // prefixIcon: Icon(Icons.person),
                        ),
                        onChanged: (value) {
                          UserName = value;
                          setState(() {});
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(

                        controller: passwordController,
                        validator: (value) {
                          if (passwordController.text == null ||
                              passwordController.text.isEmpty) {
                            return 'please enter Your password';
                          }
                        },
                        onChanged: (value) {
                          password = value;
                          setState(() {

                          });
                        },
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          focusColor: Color(0xff0AAB98),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xff0AAB98),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Color(0xff0AAB98),
                              width: 2.0,
                            ),
                          ),
                          labelText: 'enter your password',

                          // prefixIcon: Icon(Icons.person),
                        ),

                      ),
                    ),
                    SizedBox(height: 40,),
                    GestureDetector(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).login(userName: nameController.text, password: passwordController.text);

                        }
                      },
                      child: Container(
                        height: 70,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xff0AAB98),
                        ),
                        child: Center(
                          child: Text(state is LoginLoadingState?"loading...":"Sign In", style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don/'t have an account?",style: TextStyle(
                              color: Colors.black,fontSize: 20),),
                          TextButton(onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(

                                builder: ((context) => registerScreen())));
                          }, child:Text("Sign up",style: TextStyle(
                              color: Color(0xff0AAB98),fontSize: 18),),)
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
