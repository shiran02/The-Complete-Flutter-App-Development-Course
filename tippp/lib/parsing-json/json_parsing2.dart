import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class JsongpasingSimple extends StatefulWidget {
  const JsongpasingSimple({super.key});

  @override
  State<JsongpasingSimple> createState() => _JsongpasingSimpleState();
}



class _JsongpasingSimpleState extends State<JsongpasingSimple> {
  
  late Future data;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = getData();
  }
 
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Future getData() async{
    var data;

    String url = "https://jsonplaceholder.typicode.com/posts";

    Network2 network = Network2(url);
    data = network.fetchData2();
    return data;
  }

}

class Network{
  late final String url;

  Network(this.url);

  Future fetchData() async{
    Response response = await get(Uri.parse(url));

    if(response.statusCode == 200){
      return json.encode(response.body);
    }else{

    }
  }

}

class Network2{
  late final String url;

  Network2(this.url);

  Future fetchData2() async{
    Response response = await get(Uri.parse(url));

    if(response.statusCode == 2){
      return json.encode(response.body);
    }else{
      print(response.statusCode);
    }
  }


}