import 'package:flutter/material.dart';

class PosterWidget extends StatelessWidget {
  final String url;
  final String title;
  const PosterWidget({
    super.key,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: FadeInImage.assetNetwork(
        placeholder: 'assets/coverNotFound.jpg',
        placeholderFit: BoxFit.fill,
        image: url,
        fit: BoxFit.fill,
        imageErrorBuilder: (context, error, stackTrace) => Container(
          height: 300,
          width: 200,
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
    );
  }
}
