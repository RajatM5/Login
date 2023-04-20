import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


class WelcomePage extends StatefulWidget {
  // final String user_name;
  // final String user_token;
  //
  // WelcomePage(this.user_name, this.user_token);



  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  var name;
  var mobile;
  var type;

  var data;
  var status;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlist();

    setState(() {
      // getdetails();

    });

  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text('Latest Jobs'),
      ),
      body: Container(

        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Text('Welcome',style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.black),),
        // ),
        //
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child:name != null ? Text( name,style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.black),):Text('Name'),
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child:mobile != null ? Text( mobile,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),):Text('Mobile No:'),
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child:type != null ? Text( type,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),):Text('Type'),
        // ),
        // Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Text('Your Token is',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black),),
        //   ),

      child: StaggeredGridView.countBuilder(
          controller: new ScrollController(keepScrollOffset: false),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          crossAxisCount: 1,
          itemCount: /*patient.length*/data!=null? data.length:10 ,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(4),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: Container(
                height: 150,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Icon(Icons.account_circle_outlined,size: 75,)),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                         data != null ? Text('Job Id : '+data[index]['id']):Text('Id'),
                         data != null ? Text('Job Title : '+data[index]['title']):Text('Title'),
                         data != null ? Text('Job Image : '+data[index]['image']):Text('Image'),
                          // Text('Job Title : '+data != null?data[index]['title']:null),
                          // Text('Job Image Name : '+data != null?data[index]['image']:null),
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,

                    )
                  ]
                ),
              ),
            );
          }),
    )
    ));
  }

  // Future<void> getdetails() async {
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //    name = prefs.getString('name',);
  //    mobile = prefs.getString('mobile',);
  //    type = prefs.getString('type');
  // }

  Future<http.Response> getlist() async {


    // var body = json.encode({
    //   "client_id":""
    // });
    
    var url = Uri.parse('https://trickysys.com/demo/olf/androidApi/Master/getServiceList');
     http.Response response = await http.post(url);

     var ResponseJson = json.decode(response.body);

     setState(() {
       data = ResponseJson['data'];
       // status = ResponseJson['success'];
     });


     if(ResponseJson['success']==1){
       data = ResponseJson['data'];
       print(ResponseJson);
       print( ResponseJson['message']);

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
       print(ResponseJson);
       print( ResponseJson['message']);

     }

    return response;

}




}
