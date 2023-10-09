import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class TestApi extends StatefulWidget {
  const TestApi({super.key});

  @override
  State<TestApi> createState() => _TestApiState();
}

class _TestApiState extends State<TestApi> {

  late Future data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //data = getData();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text Api"),
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
    Response response = await get(Uri.parse(url));

    if(response.statusCode == 200){
      //print(json.decode(response.body));
      print(response.body);
      return json.decode(response.body);
    }else{
      print(response.statusCode);
    }

  }


}

Widget creativeListView(List data , context){
  return Container(
    child: ListView.builder(
      itemCount: data.length,
      itemBuilder: (context , index){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Divider(height: 4),
            ListTile(
              title: Text(
                "${data[index]['title']}",
                style: TextStyle(
                  color : Colors.black,
                  fontSize: 23 
                  ),

                ),
              subtitle: Text(
                "${data[index]['body']}",
                style: TextStyle(
                  color : Colors.amber,
                  fontSize: 23 
                  ),
                ),

                leading: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Text('${data[index]['userId']}'),
                ),
            )
          ],
        );
      }),
  );
}