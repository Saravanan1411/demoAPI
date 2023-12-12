import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../Models/activityModel.dart';

class ActivityAPI extends StatefulWidget {
  const ActivityAPI({super.key});

  @override
  State<ActivityAPI> createState() => _ActivityAPIState();
}

class _ActivityAPIState extends State<ActivityAPI> {

  late Future<ActivityModel> _activityFuture;

  Future<ActivityModel> activityDetails() async{
    var response = await http.get(Uri.parse("https://www.boredapi.com/api/activity"));
    return ActivityModel.fromJson(jsonDecode(response.body));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _activityFuture = activityDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<ActivityModel>(
              future: _activityFuture,
              builder: (context, snap){
                if(snap.hasData){
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey
                    ),
                    child: Column(
                      children: [
                        Text(snap.data!.activity.toString()),
                        Text(snap.data!.type.toString()),
                        Text(snap.data!.participants.toString()),
                        Text(snap.data!.price.toString()),
                        Text(snap.data!.link.toString()),
                        Text(snap.data!.key.toString()),
                        Text(snap.data!.accessibility.toString()),
                      ],
                    ),
                  );
                }
                else if (snap.hasError){
                  return Text("${snap.error}");
                }
                return const CircularProgressIndicator();
              }
          ),
        ),
    );
  }
}
