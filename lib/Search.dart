

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musicify_app/Songitem.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';



class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _MyState();
}

  
  
  class _MyState extends State<SearchPage> {
    
    
    String searched = "";
    String accessToken = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(32, 34,60, .5),
      appBar: AppBar(
        title: Text("Musicify"),
        backgroundColor: Colors.indigo[500],
      ),
      body: Stack(children: [
        Container(
            alignment: Alignment(0, -0.95),
            child: 
            SizedBox(
              width: 400,
              child: 
            TextField(
              onChanged: (value) async {
                const url = "https://accounts.spotify.com/api/token";
                var res = await http.post(
                  Uri.parse(url),
                  headers: <String, String>{
                'Content-Type': 'application/x-www-form-urlencoded',
                'Authorization':"Basic " + base64.encode(utf8.encode("2d619d57084f437aa49f91cf7197f671" + ":" + "d3ba863d303c401c84b3e8dca435704b"))

              },
              body: "grant_type=client_credentials"
                  );
   
                setState(() {
                searched = value;
                accessToken = jsonDecode(res.body)['access_token'];
                // print(value);
                  // searched = "sd";
                });
              },
              cursorColor: Color.fromRGBO(147, 43, 222, 1),
              decoration:InputDecoration(
                filled: true,
                hintText: "Search for songs",
                suffixIconColor: Color.fromRGBO(147, 43, 222, 1),
                fillColor: Color.fromRGBO(56,57,84, 1),
                border:OutlineInputBorder(
                  borderRadius:BorderRadius.circular(12),
                  borderSide: BorderSide.none
                  ),
                suffixIcon: const Icon(Icons.search)
              )
            )
            )
            ),
            SongItem(q: searched)
      ]),
    );
  }
}
