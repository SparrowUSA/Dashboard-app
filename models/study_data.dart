import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class University extends HiveObject {
  @HiveField(0)
  late String name;
}

@HiveType(typeId: 1)
class Subject extends HiveObject {
  @HiveField(0)
  late String uniName;
  @HiveField(1)
  late String title;
}

@HiveType(typeId: 2)
class Resource extends HiveObject {
  @HiveField(0)
  late String subjectTitle;
  @HiveField(1)
  late String upwriteText; // This is what you write
  @HiveField(2)
  late String url;         // This is the hidden link
}
