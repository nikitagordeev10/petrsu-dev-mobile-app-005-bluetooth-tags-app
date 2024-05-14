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

  factory Quest.fromList(List<String> questInfo) {
    return Quest(
      // id: int.parse(questInfo[0]),
      name: questInfo[1],
      description: questInfo[2],
      image: File(questInfo[3]),
    );
  }
}
