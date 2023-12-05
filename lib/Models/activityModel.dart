class ActivityModel{
  String? activity;
  String? type;
  int? participants;
  double? price;
  String? link;
  String? key;
  double? accessibility;

  ActivityModel({this.activity,this.type,this.participants,this.price,this.link,this.key,this.accessibility});

  ActivityModel.fromJson(Map<String,dynamic> json){
    activity = json['activity'] ?? "";
    type = json['type'] ?? "";
    participants = json['participants'] ?? 0;
    price = json ['price'] ?? 0.0;
    link = json['link'] ?? "";
    key = json['key'] ?? "";
    accessibility = json['accessibility'] ?? 0.0;
  }

}