import 'package:flutter/material.dart';

class ColorModel {
  int colorId;
  String name;
  Color color;

  ColorModel({this.colorId, this.name});

  ColorModel.fromJson(Map<String, dynamic> json) {
    var id = json['color_id'];
    colorId = id is String ? int.parse(id) : id;
    name = json['name'];
    color = colorsMapping[colorId];
  }

  static const colorsMapping = {
    1: Colors.white,
    2: Colors.grey,
    3: Colors.black,
    4: Colors.red,
  };

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color_id'] = this.colorId;
    data['name'] = this.name;
    return data;
  }
}
