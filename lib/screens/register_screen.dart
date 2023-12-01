import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_api_register_login_logout/screens/home_screen.dart';

import '../auth_cubit.dart';
import '../main.dart';
import '../shared/network/shared_preferences.dart';
import 'deaf_home_screen.dart';
import 'login_screen.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({Key? key}) : super(key: key);

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  bool eye = true;
  late String UserName;
  late String password;
  late String rePassword;
  late String email;
   bool selectedValue = true;
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {
          registerIsDeaf = await CacheNetwork.getIsDeaffCacheData(key:'registerIsDeaf').toLowerCase();


          print("last$registerIsDeaf");

          if(state is RegisterSucessState && registerIsDeaf=="true"){
            Navigator.pushReplacement(context, MaterialPageRoute(

                builder: ((context) => deafHomeScreen())));

          }else if(state is RegisterSucessState && registerIsDeaf=="false"){
            Navigator.pushReplacement(context, MaterialPageRoute(

                builder: ((context) => homeScreen())));

          }
        if(state is RegisterFailedState){
            showDialog(context: context, builder: ((context) => AlertDialog(
              content: Text("failed ",style: TextStyle(
                color: Colors.white,
              ),),
              backgroundColor: Colors.red,
            )));
          }
          // TODO: implement listener
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
                      SizedBox(height: 75,),
                      Text("   Deaf App", style: TextStyle(
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
                            if (nameController.text == null || nameController.text.isEmpty) {
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

                          controller: emailController,
                          validator: (value) {
                            if (emailController.text == null || emailController.text.isEmpty) {
                              return 'please enter Your email';
                            }
                          },
                          onChanged: (value) {
                            email = value;
                            setState(() {

                            });
                          },
                          keyboardType: TextInputType.emailAddress,

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
                            labelText: '  enter your email',

                            // prefixIcon: Icon(Icons.person),
                          ),

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(

                          controller: passwordController,
                          validator: (value) {
                            if (passwordController.text == null || passwordController.text .isEmpty) {
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
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("  type:", style: TextStyle(
                                color: Colors.black,
                                fontSize: 35),),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.all(10.0),
                              color: Color(0xff0AAB98),
                              child: DropdownButton(
                                  dropdownColor: Color(0xff0AAB98),

                                  value: selectedValue,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("Deaf", style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20),),
                                      value: true,
                                    ),
                                    DropdownMenuItem(
                                      child: Text(
                                        "Non Deaf", style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20),),
                                      value: false,
                                    ),
                                  ],
                                  onChanged: ( value) {
                                    setState(() {
                                      selectedValue = value!;
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_formkey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context).register(
                                userName: nameController.text, email: emailController.text,
                                 password: passwordController.text ,isDeaf: selectedValue.toString());


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
                            child: Text(state is RegisterLoadingState?"loading...":"Sign Up", style: TextStyle(
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
                            Text("already have account?",style: TextStyle(
                                color: Colors.black,fontSize: 20),),
                            TextButton(onPressed: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(

                                  builder: ((context) => loginScreen())));
                            }, child:Text("log in",style: TextStyle(
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
