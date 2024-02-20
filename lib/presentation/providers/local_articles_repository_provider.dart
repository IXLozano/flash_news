import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/factories/app_factory.dart';

final localArticlesRepositoryProvider =
    Provider((ref) => AppFactory.getLocalArticlesRepository());
