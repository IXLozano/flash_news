import 'package:flash_news/config/helpers/format_helper.dart';
import 'package:flash_news/domain/entities/article.dart';
import 'package:flutter/material.dart';

class TitleAndDescription extends StatelessWidget {
  final Article article;
  final Size size;
  const TitleAndDescription({
    super.key,
    required this.article,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.grey.shade800, borderRadius: BorderRadius.circular(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Article Image, Publish Date and Author
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: (article.urlToImage != '')
                    ? SizedBox(
                        height: 100,
                        child: Image.network(
                          article.urlToImage,
                          fit: BoxFit.cover,
                          width: size.width * 0.3,
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            // Here you can return any widget you want to show in case of an error.
                            // For example, an icon or a placeholder image.
                            return SizedBox(
                              height: 100,
                              width: size.width * 0.3,
                              child: const Icon(Icons.newspaper_outlined,
                                  size: 60),
                            );
                          },
                        ),
                      )
                    : SizedBox(
                        height: 100,
                        width: size.width * 0.3,
                        child: const Icon(Icons.newspaper_outlined, size: 60),
                      ),
              ),
              const SizedBox(height: 8),

              // Author
              const Text(
                'Author:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              (article.author.length > 13)
                  ? Text('${article.author.substring(0, 13)}...')
                  : Text(article.author),
              const SizedBox(height: 10),

              //Publish Date
              Text(FormatHelper.shortDate(
                  article.publishedAt ?? DateTime.now())),
            ],
          ),
          const SizedBox(width: 10),

          //* Title and Description
          SizedBox(
            width: size.width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                (article.title.length > 45)
                    ? Text(
                        '${article.title.substring(0, 45)}...',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )
                    : Text(
                        article.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                const SizedBox(height: 5),

                // Description
                (article.description.length > 140)
                    ? Text('${article.description.substring(0, 140)}...')
                    : Text(article.description),
              ],
            ),
          )
        ],
      ),
    );
  }
}
