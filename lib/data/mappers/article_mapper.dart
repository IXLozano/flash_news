import 'package:uuid/uuid.dart';

import '../../domain/entities/article.dart';
import '../models/article_response_dto.dart';

class ArticleMapper {
  static Article fromDtoToEntity(ArticleDTO dto) {
    const uuid = Uuid();
    return Article(
      articleId: uuid.v4(),
      source: dto.source,
      author: dto.author,
      title: dto.title,
      description: dto.description,
      url: dto.url,
      urlToImage: dto.urlToImage,
      publishedAt: dto.publishedAt,
      content: dto.content,
    );
  }
}
