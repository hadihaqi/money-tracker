import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Category {
  Category({
    required this.userId,
    required this.title,
    required this.icon,
    required this.color,
  }) : id = uuid.v4();

  final String id;
  final String userId;
  final String title;
  final Icon icon;
  final Color color;
}
