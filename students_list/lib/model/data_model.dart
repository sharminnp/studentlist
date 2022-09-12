import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class studentmodel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String age;
  @HiveField(2)
  final String place;
  @HiveField(3)
  final String adhar;
  @HiveField(4)
  final String image;

  studentmodel({
    required this.name,
    required this.age,
    required this.place,
    required this.adhar,
    required this.image,
  });
}
