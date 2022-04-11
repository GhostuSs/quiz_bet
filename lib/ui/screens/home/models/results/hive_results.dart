import 'package:hive/hive.dart';

part 'hive_results.g.dart';

@HiveType(typeId: 0)
class HiveResult extends HiveObject {
  @HiveField(0)
  String? quizIndex;
  @HiveField(1)
  String? correctAnswers;

  HiveResult({this.quizIndex, this.correctAnswers});
}
