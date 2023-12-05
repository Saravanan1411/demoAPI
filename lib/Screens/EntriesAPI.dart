import 'dart:convert';

import 'package:flutter/material.dart';

import '../Models/OrgEntryFile.dart';
import 'package:http/http.dart' as http;

class EntriesAPI extends StatefulWidget {
  const EntriesAPI({super.key});

  @override
  State<EntriesAPI> createState() => _EntriesAPIState();
}

class _EntriesAPIState extends State<EntriesAPI> {

  Future<List<Entries>> FetchEntriesList() async{
    var resp = await http.get(Uri.parse("https://api.publicapis.org/entries"));
    var data = jsonDecode(resp.body)["entries"]; // getting only the values of entries
    // if (data != null) {
    //   var entries = <Entries>[];
    //   data.forEach((v) {
    //     entries!.add(new Entries.fromJson(v));
    //   });
    // }
    return (data as List).map((e) => Entries.fromJson(e) ).toList();

  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchEntriesList(); // initializing the data fetching api method
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder<List<Entries>>(
              future: FetchEntriesList(),
              builder: (context, snap){
                if(snap.hasData){
                  List<Entries> list = snap.data!; //inserting the data into a list
                  return ListView.builder(
                    itemCount: list.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Column(
                          children: [
                            Text(list[index].category.toString()),
                            Text(list[index].aPI.toString()),
                          ],
                        ),
                      );
                    },
                  );
                }
                else if (snap.hasError){
                  return Text("${snap.error}");
                }
                return const CircularProgressIndicator();
              }
          ),
        ),
      ),
    );
  }
}
