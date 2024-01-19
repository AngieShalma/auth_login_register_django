import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class userInfoScreen extends StatefulWidget {
  const userInfoScreen({Key? key}) : super(key: key);

  @override
  State<userInfoScreen> createState() => _userInfoScreenState();
}

class _userInfoScreenState extends State<userInfoScreen> {
  late String UserName;

  final nameController = TextEditingController();
  File? image;

  Future pickerCamera() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      image = File(myfile!.path);
    });
  }

  Future pickerGallery() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      image = File(myfile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        // background color of your snack-bar
                        backgroundColor: Color(0xff0AAB98),
                        // make the content property take a Row
                        content: Row(
                          children: <Widget>[
                            // add your preferred icon here
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25,
                              child: IconButton(
                                onPressed: () {

                                   showDialog(
                                     context: context,
                                     builder: (BuildContext context) {
                                       // return object of type Dialog
                                       return AlertDialog(

                                         title: Text("Deaf App"),
                                         content: Text(
                                             "would you like to Acess Your Camera"),
                                         actions: <Widget>[

                                           TextButton(
                                             child: Text("cancel"),
                                             onPressed: () {
                                               Navigator.of(context).pop();
                                             },
                                           ),
                                           TextButton(
                                             child: Text("accept"),
                                             onPressed: () {
                                               pickerCamera();                                        },
                                           ),
                                         ],
                                       );
                                     },
                                   );
                                },
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Color(0xff0AAB98),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      // return object of type Dialog
                                      return AlertDialog(
                                        title: Text("Deaf App"),
                                        content: Text(
                                            "would you like to Acess Your Gallery"),
                                        actions: <Widget>[

                                          TextButton(
                                            child: Text("cancel"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text("accept"),
                                            onPressed: () {
                                              pickerGallery();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                },
                                icon: Icon(
                                  Icons.photo,
                                  color: Color(0xff0AAB98),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // the duration of your snack-bar
                        duration: Duration(days: 1),
                      ));
                      // pickerCamera();
                    },
                    child: CircleAvatar(
                      radius: 59,
                      backgroundImage: image == null
                          ? AssetImage("assets/images/images.jpeg")
                              as ImageProvider
                          : FileImage(image!),
                      backgroundColor: Colors.white,
                      // child:image== Image.asset("assets/images/images.jpeg",height: 118,width: 118,)?null:FileImage(image!)
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: GestureDetector(
                  // onTap: (){
                  //   pickerCamera();
                  // },
                  child: CircleAvatar(
                    radius: 15,
                    // backgroundImage:image==null?null:FileImage(image!),

                    backgroundColor: Color(0xff0AAB98),
                    child: Image.asset(
                      "assets/images/Camera Icon.png",
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter Your Name';
                }
              },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                filled: true,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffD6D6D6)),
                ),
                // border: OutlineInputBorder(),
                labelText: ' userame',
                labelStyle: TextStyle(
                  color: Color(0xffA6ABC4), //<-- SEE HERE
                ),
                // prefixIcon: Icon(Icons.person),
              ),
              onChanged: (value) {
                nameController.text = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Container(
            height: 70,
            width: 300,
            decoration: BoxDecoration(
                color: Color(0xff0AAB98),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                "save",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
