import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final int id;
  final String title;
  final String posterUrl;
  const MovieCard({
    super.key,
    required this.id,
    required this.title,
    required this.posterUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/movie', arguments: id);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/coverNotFound.jpg',
          placeholderFit: BoxFit.fill,
          image: posterUrl,
          fit: BoxFit.fill,
          imageErrorBuilder: (context, error, stackTrace) => Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(14),
              ),
              color: Colors.white70,
            ),
            child: Center(
              child: Text(
                title,
                textScaleFactor: 1.7,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
