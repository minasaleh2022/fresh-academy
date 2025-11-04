import 'repo_iface.dart';
import 'hive_repo.dart';
import 'rest_repo.dart';

enum DataMode { local, remote }
class RepoProvider {
  static DataMode mode = DataMode.local; // بدّلها إلى DataMode.remote للربط بـ REST
  static IDataRepo get repo => mode == DataMode.local ? HiveRepoAdapter() : RestRepo();
}
