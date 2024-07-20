import 'package:hive/hive.dart';

part 'notes_model.g.dart';

@HiveType(typeId: 0)
class NotesModel extends HiveObject {

  @HiveField(0)
  String? title;

  @HiveField(1)
  String? date;

  @HiveField(2)
  String? weight;

  @HiveField(3)
  String? price;

  NotesModel({required this.title, required this.date, required this.weight, required this.price});
}