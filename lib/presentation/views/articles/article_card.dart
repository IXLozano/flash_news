import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../config/helpers/format_helper.dart';
import '../../../domain/entities/article.dart';
import '../../widgets/shared/favorite_toggle_button.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  final Size size;
  const ArticleCard({
    super.key,
    required this.article,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(16),
      ),
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
                    ? FadeIn(
                        delay: const Duration(milliseconds: 700),
                        child: SizedBox(
                          height: 100,
                          child: Image.network(
                            article.urlToImage,
                            fit: BoxFit.cover,
                            width: size.width * 0.3,
                            errorBuilder: (
                              BuildContext context,
                              Object error,
                              StackTrace? stackTrace,
                            ) {
                              // Here you can return any widget you want to show
                              // in case of an error.
                              // For example, an icon or a placeholder image.
                              return SizedBox(
                                height: 100,
                                width: size.width * 0.3,
                                child: const Icon(
                                  Icons.newspaper_outlined,
                                  size: 60,
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : FadeIn(
                        delay: const Duration(milliseconds: 500),
                        child: SizedBox(
                          height: 100,
                          width: size.width * 0.3,
                          child: const Icon(Icons.newspaper_outlined, size: 60),
                        ),
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
              Text(
                FormatHelper.shortDate(
                  article.publishedAt ?? DateTime.now(),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),

          //* Title, Favorite Button and Description
          SizedBox(
            width: size.width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Favorite Button
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    (article.title.length > 45)
                        ? SizedBox(
                            width: size.width * 0.48,
                            child: Text(
                              '${article.title.substring(0, 45)}...',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          )
                        : SizedBox(
                            width: size.width * 0.4,
                            child: Text(
                              article.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                    const SizedBox(height: 5),
                    const Spacer(),
                    FavoriteToggleButton(article: article),
                  ],
                ),

                // Description
                (article.description.length > 140)
                    ? Text('${article.description.substring(0, 140)}...')
                    : Text(article.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
