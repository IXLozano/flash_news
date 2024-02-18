import 'package:flash_news/config/factories/app_factory.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final articlesRepositoryProvider =
    Provider((ref) => AppFactory.getArticleRepository());