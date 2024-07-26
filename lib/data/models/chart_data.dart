import 'package:contacts_flutter/data/models/contact.dart';

class ChartData {
  String range;
  int count;
  ChartData(this.range, this.count);
}

class GenderData {
  Gender gender;
  int count;
  GenderData({
    required this.gender,
    required this.count,
  });
}
