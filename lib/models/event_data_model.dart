import 'package:evently/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventDataModel {
  final String id;
  final String name;
  final String lightImage;
  final String darkImage;
  final SvgGenImage icon;
  EventDataModel({
    required this.id,
    required this.name,
    required this.lightImage,
    required this.darkImage,
    required this.icon,
  });

}
