import 'dart:io';

class Quest {
  // final int id;
  final String name;
  final String description;
  final File image;

  Quest({
    // required this.id,
    required this.name,
    required this.description,
    required this.image});


// factory Quest.fromSqfliteDatabase(Map<String, dynamic> map) => Quest(
//   id: map['id']?.toInt() ?? 0,
//   name: map['name'] ?? '',
//   description: map['description'] ?? '',
//   image: map['image'] ?? '',
// );

}