import 'package:hive/hive.dart';

// Run 'flutter pub run build_runner build' to generate the adapter
@HiveType(typeId: 0)
class StudyResource {
  @HiveField(0)
  final String uniName;
  @HiveField(1)
  final String subjectName;
  @HiveField(2)
  final String upwriteText; // Your notes
  @HiveField(3)
  final String hiddenUrl;   // The link
  @HiveField(4)
  final DateTime dateAdded;

  StudyResource({
    required this.uniName,
    required this.subjectName,
    required this.upwriteText,
    required this.hiddenUrl,
    required this.dateAdded,
  });
}
