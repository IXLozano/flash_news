import 'package:flash_news/data/models/article_response_dto.dart';
import 'package:flash_news/domain/entities/article.dart';

class ArticleMapper {
  static Article fromDtoToEntity(ArticleDTO dto) {
    return Article(
      source: dto.source,
      author: dto.author,
      title: dto.title,
      description: dto.description,
      url: dto.url,
      urlToImage: dto.urlToImage != ''
          ? dto.urlToImage
          : 'https://static.wixstatic.com/media/9cc095_9b04eb0fe8554c94a2d317e1db432635~mv2.jpg/v1/fill/w_740,h_321,al_c,lg_1,q_80,enc_auto/9cc095_9b04eb0fe8554c94a2d317e1db432635~mv2.jpg',
      publishedAt: dto.publishedAt,
      content: dto.content,
    );
  }
}
