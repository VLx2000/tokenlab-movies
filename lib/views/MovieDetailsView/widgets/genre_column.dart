import 'package:flutter/material.dart';

class GenreWidget extends StatelessWidget {
  final dynamic genres;
  const GenreWidget({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Title(
            color: Colors.black,
            child: const Text(
              "Gêneros",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        if (genres != null)
          for (var genre in genres!) Text("- $genre"),
      ],
    );
  }
}
