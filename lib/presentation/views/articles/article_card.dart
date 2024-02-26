import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../config/helpers/format_helper.dart';
import '../../../domain/entities/article.dart';
import '../../widgets/shared/favorite_toggle_button.dart';

class ArticleCard extends StatefulWidget {
  final Article article;
  final Size size;
  const ArticleCard({
    super.key,
    required this.article,
    required this.size,
  });

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  bool isExpanded = false;
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
                child: (widget.article.urlToImage != '')
                    ? FadeIn(
                        delay: const Duration(milliseconds: 700),
                        child: SizedBox(
                          height: 100,
                          child: Image.network(
                            widget.article.urlToImage,
                            fit: BoxFit.cover,
                            width: widget.size.width * 0.3,
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
                                width: widget.size.width * 0.3,
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
                          width: widget.size.width * 0.3,
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
              (widget.article.author.length > 13)
                  ? Text('${widget.article.author.substring(0, 13)}...')
                  : Text(widget.article.author),
              const SizedBox(height: 10),

              //Publish Date
              Text(
                FormatHelper.shortDate(
                  widget.article.publishedAt ?? DateTime.now(),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),

          //* Title, Favorite Button, Description and Content
          SizedBox(
            width: widget.size.width * 0.6,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Favorite Button
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    (widget.article.title.length > 45)
                        ? SizedBox(
                            width: widget.size.width * 0.48,
                            child: Text(
                              '${widget.article.title.substring(0, 45)}...',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          )
                        : SizedBox(
                            width: widget.size.width * 0.4,
                            child: Text(
                              widget.article.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                    const SizedBox(height: 5),
                    const Spacer(),
                    FavoriteToggleButton(article: widget.article),
                  ],
                ),

                // Description
                (widget.article.description.length > 140)
                    ? Text('${widget.article.description.substring(0, 140)}...')
                    : Text(widget.article.description),

                TextButton(
                  onPressed: () => setState(() => isExpanded = !isExpanded),
                  child: Text(
                    isExpanded ? 'See less' : 'See more',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Content
                if (isExpanded) Text(widget.article.content),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
