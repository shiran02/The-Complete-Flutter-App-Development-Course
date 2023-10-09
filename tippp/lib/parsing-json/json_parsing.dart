import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class JsonPardeingSimple extends StatefulWidget {
  const JsonPardeingSimple({super.key});

  @override
  State<JsonPardeingSimple> createState() => _JsonPardeingSimpleState();
}

class _JsonPardeingSimpleState extends State<JsonPardeingSimple> {

  late Future data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    data = getData();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parsing Json'),
      ),

      body: Center(
        child: Container(
          child: FutureBuilder(
            future: getData(),
            builder: (context,AsyncSnapshot snapshot){
              if(snapshot.hasData){
                return creativeListView(snapshot.data , context);
                //return Text(snapshot.data[0]['title']);
              }else{
                return CircularProgressIndicator();
              }
            }),
        ),
      ),
    );
  }

  Future getData() async{ 
    var data;
    String url = "https://jsonplaceholder.typicode.com/posts";
    Network network = Network(url);

    data = network.fetchData();
    //print(data);

  data.then((value){
    // print(value[0]['userId']);
    // print(value[0]['id']);
    // print(value[0]['title']);
  });

    return data;
  }
  
  Widget creativeListView(List data, BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context,int index){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(height: 4,),
              ListTile(
                title: Text("${data[index]['title']}"),
                subtitle: Text("${data[index]["body"]}"),
                leading: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.amberAccent,
                      radius: 23,
                      child: Text("${data[index]['userId']}"),
                    )
                  ],
                ),
              )
            ],
          );
        }),
    );
  }

  
}

//-----------------------------------





//----------------------------------

class Network{
  final String url;


  Network(this.url);

  Future fetchData() async{
    

    print("$url");

    Response response = await get(Uri.parse(url));


    if(response.statusCode == 200){

      print(response.body[0]);
 //     print(response.body);
      return json.decode(response.body);
    }else{
      print(response.statusCode);
    }
  }

}