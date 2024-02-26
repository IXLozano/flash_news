import 'package:isar/isar.dart';

abstract interface class IDatabaseManager {
  Future<Isar> getDatabase();
}
