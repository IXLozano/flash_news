import 'package:flash_news/data/models/article_response_dto.dart';
import 'package:flash_news/domain/entities/article.dart';
import 'package:uuid/uuid.dart';

class ArticleMapper {
  static Article fromDtoToEntity(ArticleDTO dto) {
    var uuid = const Uuid();
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
