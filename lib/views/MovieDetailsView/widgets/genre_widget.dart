import 'package:flutter/material.dart';

class GenreWidget extends StatelessWidget {
  final dynamic genres;
  const GenreWidget({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            "Gêneros",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        if (genres != null)
          for (var genre in genres!)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: Colors.black38,
              ),
              child: Text("$genre"),
            ),
      ],
    );
  }
}
