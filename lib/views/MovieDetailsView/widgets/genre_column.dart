import 'package:flutter/material.dart';

class GenreColumn extends StatelessWidget {
  final dynamic genres;
  const GenreColumn({super.key, required this.genres});

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
