import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? text;

  @HiveField(3)
  DateTime? createdDate;

  @HiveField(4)
  int? order;

  NoteModel({
    this.id,
    this.title,
    this.text,
    this.createdDate,
    this.order,
  });

  NoteModel copyWith({
    int? id,
    String? title,
    String? text,
    DateTime? createdDate,
    int? order,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      text: text ?? this.text,
      createdDate: createdDate ?? this.createdDate,
      order: order ?? this.order,
    );
  }
}
