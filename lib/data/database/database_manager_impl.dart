import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../config/database/i_database_manager.dart';
import '../../domain/entities/article.dart';

class DatabaseManager implements IDatabaseManager {
  @override
  Future<Isar> getDatabase() async {
    try {
      if (Isar.instanceNames.isEmpty) {
        final dir = await getApplicationDocumentsDirectory();
        return await Isar.open(
          [ArticleSchema],
          directory: dir.path,
          inspector: true,
        );
      }
      return Future.value(Isar.getInstance());
    } catch (e) {
      throw Exception('Failed to open Isar database');
    }
  }
}
