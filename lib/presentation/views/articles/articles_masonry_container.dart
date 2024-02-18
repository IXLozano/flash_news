import 'package:animate_do/animate_do.dart';
import 'package:flash_news/domain/entities/article.dart';
import 'package:flutter/material.dart';

class ArticleMasonryContainer extends StatelessWidget {
  final Article article;
  const ArticleMasonryContainer({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            FadeInImage(
              height: 220,
              width: double.infinity,
              fit: BoxFit.contain,
              placeholder: NetworkImage(article.urlToImage),
              image: NetworkImage(article.urlToImage),
            ),
            Positioned(
              bottom: 0,
              child: FadeIn(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 280),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.0],
                      colors: [
                        Colors.transparent,
                        Colors.black87,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: SizedBox(
                      width: 150,
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow.shade800,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            article.author,
                            style: const TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
