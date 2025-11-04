import 'data/hive_repo.dart';
Future<void> bootstrap() async {
  await hiveRepo.seedIfEmpty();
}
