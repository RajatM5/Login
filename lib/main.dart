import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:newlogin/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController controlleremail = TextEditingController();
  final TextEditingController controllerpass = TextEditingController();
  bool isload = false;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(

        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
              Text('Login',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26),),
              Text('Sign-In to your Account',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.blue),),
              SizedBox(height: 20,),

              // Email Inputtext
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                child: TextFormField(
                  controller: controlleremail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600
                    ),
                    prefixIcon: Icon(Icons.email_outlined,color: Colors.grey,),
                    focusColor: Colors.grey,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),

                  ),
                ),
              ),
              // Password Inputtext
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                child: TextFormField(
                  controller: controllerpass,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600
                    ),
                    prefixIcon: Icon(Icons.key,color: Colors.grey,),
                    focusColor: Colors.grey,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),

                  ),
                ),
              ),
              SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text('New here? Sign-Up here',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.blue),),
              ),
              Text('Forget Password',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.blue),),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if(controlleremail.value.text.isEmpty){
                          Fluttertoast.showToast(
                              msg: 'Please enter Email Id',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
                        // else if(!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b').hasMatch(controlleremail.value.text)){
                        //   Fluttertoast.showToast(
                        //       msg: 'Please enter valid Email Id',
                        //       toastLength: Toast.LENGTH_SHORT,
                        //       gravity: ToastGravity.BOTTOM,
                        //       timeInSecForIosWeb: 1,
                        //       backgroundColor: Colors.red,
                        //       textColor: Colors.white,
                        //       fontSize: 16.0
                        //   );
                        // }
                        else if(controllerpass.value.text.isEmpty){
                          Fluttertoast.showToast(
                              msg: 'Please enter Password',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }else{
                          getlogin();
                          // SharedPreferences prefs = await SharedPreferences.getInstance();
                          // prefs.clear();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellow.shade600, // Background color
                      ),
                      child:
                      isload ? Container(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,),
                      ): Text(
                        'Login',
                        style: TextStyle(fontSize: 20,color: Colors.black),
                      ),
                    )
                ),
              )
            ]
        ),
      ),
      );
  }

  // Future<http.Response> getlogin() async {
  //
  //   setState(() {
  //     isload = true;
  //   });
  //
  //   var body = json.encode(
  //       {
  //         "username":controlleremail.text,
  //         "password":controllerpass.text
  //       }
  //   );
  //
  //   var url = Uri.parse('https://demo-quantio-funcapp-eus.azurewebsites.net/api/LoginUser');
  //   http.Response response = await http.post(url, body: body);
  //
  //     var ResponseJson = json.decode(response.body);
  //
  //     var message =  ResponseJson["message"];
  //
  //   if(ResponseJson["error"] == false){
  //
  //     var user_token = ResponseJson["data"]["token"];
  //     var user_name = ResponseJson["data"]["name"];
  //
  //     Fluttertoast.showToast(
  //         msg: ResponseJson["message"],
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.green,
  //         textColor: Colors.white,
  //         fontSize: 16.0
  //     );
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (context) => WelcomePage(user_name,user_token)),
  //           (Route<dynamic> route) => false,
  //     );
  //
  //     print(user_name.toString());
  //
  //   }else{
  //
  //     Fluttertoast.showToast(
  //         msg: ResponseJson["message"],
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0
  //     );
  //   }
  //   setState(() {
  //     isload  = false;
  //   });
  //
  //   return response;
  //
  // }

  Future<http.Response> getlogin() async{

   setState(() {
     isload =  true;

   });



    var body = json.encode({
      "email":controlleremail.text,
      "password":controllerpass.text
    });
    
    var url = Uri.parse("https://trickysys.com/demo/olf/androidApi/Master/clientLogin");
    http.Response response = await http.post(url,body: body);

    var ResponseJson = json.decode(response.body);

    if(ResponseJson['success']==1){

      Fluttertoast.showToast(
          msg: ResponseJson['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );

      var id = ResponseJson['data']['id'];
      var name = ResponseJson['data']['customer_name'];
      var mobile = ResponseJson['data']['mobile'];
      var type = ResponseJson['login_flag'];

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('id',id);
      prefs.setString('name',name);
      prefs.setString('mobile',mobile);
      prefs.setString('type',type);

      print(prefs.getString(name));
      print(ResponseJson['data']['customer_name']);
      print(ResponseJson['data']['mobile']);
      print(ResponseJson['login_flag']);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomePage()),
                // (Route<dynamic> route) => false,
          );

    }else{
      Fluttertoast.showToast(
          msg: ResponseJson['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
   setState(() {

     isload =  false;
   });
    return response;

  }



}
